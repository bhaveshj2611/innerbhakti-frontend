import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/program_model.dart';

class ApiService {
  static String baseUrl = dotenv.env['BASE_URL']!;
  static Future<List<Program>> fetchPrograms() async {
    final response = await http.get(Uri.parse('$baseUrl/programs'));
    // print(response.body);
    if (response.statusCode == 200) {
      // print(response.body);

      final List programs = json.decode(response.body);
      // print(programs);

      // print(programs.map((json) => Program.fromJson(json)).toList());
      return programs.map((json) => Program.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load programs');
    }
  }

  static Future<Program> fetchProgramDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/program-details/$id'));

    if (response.statusCode == 200) {
      return Program.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load program details');
    }
  }

  static Future<Map<String, dynamic>> fetchAudio(
      String programId, String trackTitle) async {
    final response = await http.get(
      Uri.parse(
          '$baseUrl/audio?programId=$programId&trackTitle=${Uri.encodeComponent(trackTitle)}'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch audio details');
    }
  }
}
