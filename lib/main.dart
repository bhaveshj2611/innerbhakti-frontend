import 'package:flutter/material.dart';
import 'package:innerbhakti/controller/audio_controller.dart';
import 'package:innerbhakti/controller/program_controller.dart';
import 'package:innerbhakti/model/program_model.dart';
import 'package:innerbhakti/routes/custom_route.dart';
import 'package:innerbhakti/routes/route_name.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:innerbhakti/utils/app_color.dart';
import 'package:innerbhakti/view/program_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProgramController()),
        ChangeNotifierProvider(create: (_) => AudioController())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InnerBhakti',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.program,
      onGenerateRoute: CustomRoute.allRoutes,
      theme: ThemeData(
        fontFamily: 'Recoleta',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        useMaterial3: true,
      ),
      home: const ProgramListScreen(),
    );
  }
}
