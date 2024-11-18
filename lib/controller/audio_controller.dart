import 'package:flutter/material.dart';
import '../utils/api_service.dart';

class AudioController with ChangeNotifier {
  String _programImage = '';
  String _audioUrl = '';
  String _description = '';
  bool _isLoading = false;

  String get programImage => _programImage;
  String get audioUrl => _audioUrl;
  String get description => _description;
  bool get isLoading => _isLoading;


  Future<void> fetchAudio(String programId, String trackTitle) async {
    _isLoading = true;
    notifyListeners();

    try {
      final audioDetails = await ApiService.fetchAudio(programId, trackTitle);
      _programImage = audioDetails['programImage'];
      _audioUrl = audioDetails['audioUrl'];
      _description = audioDetails['description'];
    } catch (error) {
      print('Error fetching audio: $error');
    }

    _isLoading = false;
    notifyListeners();
  }
}
