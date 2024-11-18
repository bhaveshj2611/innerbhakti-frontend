import 'package:flutter/material.dart';
import 'package:innerbhakti/widgets/player_buttons.dart';
import 'package:just_audio/just_audio.dart';
import 'package:innerbhakti/utils/app_color.dart';
import 'package:provider/provider.dart';
import '../controller/audio_controller.dart';

class AudioPlayerView extends StatefulWidget {
  final String programId;
  final String trackName;

  const AudioPlayerView({
    required this.programId,
    required this.trackName,
    super.key,
  });

  @override
  _AudioPlayerViewState createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  late AudioPlayer _audioPlayer;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

  
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AudioController>(context, listen: false)
          .fetchAudio(widget.programId, widget.trackName)
          .then((_) {
        final audioUrl =
            Provider.of<AudioController>(context, listen: false).audioUrl;

        _initAudioPlayer(audioUrl);
      });
    });
  }

  Future<void> _initAudioPlayer(String audioUrl) async {
    try {
      await _audioPlayer.setUrl(audioUrl);
      _audioPlayer.play();

      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _currentPosition = position;
        });
      });

      _audioPlayer.durationStream.listen((duration) {
        if (duration != null) {
          setState(() {
            _totalDuration = duration;
          });
        }
      });
    } catch (e) {
      print("Error initializing audio player: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final description =
        Provider.of<AudioController>(context, listen: false).description;
    return Scaffold(
      body: Consumer<AudioController>(
        builder: (context, audioController, child) {
          return Stack(
            children: [
              Container(color: AppColor.primary),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColor.secondary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(800),
                        topRight: Radius.circular(800),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColor.tertiary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(600),
                        topRight: Radius.circular(600),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColor.quad,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(400),
                        topRight: Radius.circular(400),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios,
                                color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Text(
                            widget.trackName,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: audioController.isLoading
                            ? const CircularProgressIndicator()
                            : Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(32)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        audioController.programImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      widget.trackName,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.share,
                                        color: Colors.black),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.favorite_border,
                                        color: Colors.black),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildAudioControls(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAudioControls() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Column(
        children: [
          Slider(
            value: _currentPosition.inSeconds.toDouble(),
            max: _totalDuration.inSeconds.toDouble(),
            activeColor: AppColor.bgColor2,
            min: 0.0,
            onChanged: (value) async {
              final newPosition = Duration(seconds: value.toInt());
              await _audioPlayer.seek(newPosition);
              setState(() {
                _currentPosition = newPosition;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(_currentPosition),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  formatDuration(_totalDuration),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildButton(Icons.replay_10, _rewindAudio),
              const SizedBox(width: 16),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: IconButton(
                  icon: Icon(
                    _audioPlayer.playing ? Icons.pause : Icons.play_arrow,
                    size: 32,
                    color: AppColor.bgColor,
                  ),
                  onPressed: _playPauseAudio,
                ),
              ),
              const SizedBox(width: 16),
              buildButton(Icons.forward_10, _forwardAudio),
            ],
          ),
          const SizedBox(height: 32)
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _rewindAudio() {
    final newPosition = _currentPosition - const Duration(seconds: 10);
    _audioPlayer
        .seek(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  void _forwardAudio() {
    final newPosition = _currentPosition + const Duration(seconds: 10);
    _audioPlayer
        .seek(newPosition < _totalDuration ? newPosition : _totalDuration);
  }

  void _playPauseAudio() {
    _audioPlayer.playing ? _audioPlayer.pause() : _audioPlayer.play();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
