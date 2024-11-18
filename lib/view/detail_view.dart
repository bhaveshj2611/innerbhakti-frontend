import 'package:flutter/material.dart';
import 'package:innerbhakti/routes/route_name.dart';
import 'package:innerbhakti/utils/app_color.dart';
import '../model/program_model.dart';
import '../utils/api_service.dart';

class DetailsView extends StatelessWidget {
  final String programId;

  const DetailsView({super.key, required this.programId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor2,
        body: FutureBuilder<Program>(
          future: ApiService.fetchProgramDetails(programId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final program = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
                Stack(
                  children: [
                 
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(program.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Text(
                        program.name,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: AppColor.componentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16),
                    child: Text(
                      program.description,
                      style: const TextStyle(
                        fontFamily: 'HostGrotesk',
                        fontSize: 16,
                        color: AppColor.bgColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
          
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: program.tracks.length,
                    itemBuilder: (context, index) {
                      final track = program.tracks[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteName.player,
                            arguments: {
                              'trackName': track.title,
                              'programId': program.id,
                            },
                          );
                          print(
                              'Navigating to player with: programId=$programId, trackName=${track.title}');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 0.2,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                track.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'HostGrotesk',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                track.description,
                                style: TextStyle(
                                  fontFamily: 'GeistMono',
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                IconButton(
                  padding: const EdgeInsets.all(16),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8)
              ],
            );
          },
        ),
      ),
    );
  }
}
