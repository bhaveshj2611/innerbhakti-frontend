import 'package:flutter/material.dart';
import 'package:innerbhakti/model/program_model.dart';
import 'package:innerbhakti/routes/route_name.dart';
import 'package:innerbhakti/view/detail_view.dart';
import 'package:innerbhakti/view/player_view.dart';
import 'package:innerbhakti/view/program_view.dart';

class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case RouteName.program:
          return const ProgramListScreen();
        case RouteName.programDetails:
          final program = settings.arguments as Program;
          return DetailsView(
            programId: program.id!,
          );
        case RouteName.player:
          final args = settings.arguments as Map<String, String?>;
          return AudioPlayerView(
            programId: args['programId']!,
            trackName: args['trackName']!,
          );

        default:
          return const Scaffold(body: Center(child: Text('Route not found')));
      }
    });
  }
}
