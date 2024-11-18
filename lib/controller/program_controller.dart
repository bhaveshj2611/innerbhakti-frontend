import 'package:flutter/material.dart';
import 'package:innerbhakti/model/program_model.dart';
import '../utils/api_service.dart';

class ProgramController with ChangeNotifier {
  List<Program> _programs = [];
  bool _isLoading = false;

  List<Program> get programs => _programs;
  bool get isLoading => _isLoading;

  Future<void> fetchPrograms() async {
    _isLoading = true;
    notifyListeners();

    try {
      _programs = await ApiService.fetchPrograms();
      print("Programs loaded: ${_programs.length}");
    } catch (error) {
      print('Error fetching programs: $error');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchProgramDetails(String programId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _programs = (await ApiService.fetchProgramDetails(programId)) as List<Program>;
    } catch (error) {
      print('Error fetching program details: $error');
    }

    _isLoading = false;
    notifyListeners();
  }
}
