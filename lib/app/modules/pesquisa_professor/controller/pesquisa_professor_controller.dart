import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hiperprof/app/modules/pesquisa_professor/services/pesquisa_professor_service.dart';
import 'package:hiperprof/routes.dart';
import '../../../data/models/professor_model.dart';

class PesquisaProfessorController extends ChangeNotifier {
  final PesquisaProfessorSerivice _serivice = PesquisaProfessorSerivice();
  final Function(String route, Professor professor) onNavigatorProfessor;

  Timer? _debounce;
  List<Professor> professores = [];

  PesquisaProfessorController({required this.onNavigatorProfessor});

  void selectProfessor(Professor professor) {
    onNavigatorProfessor(Routes.DETALHE_PROFESSOR, professor);
  }

  Future<List<Professor>> getAllProfessor(String? search) async {
    try {
      professores =  await _serivice.getAllProfessores(search);
       notifyListeners();
      return professores;
    } catch (erro) {
      rethrow;
    }
  }

  void onSearchDebounce(String? search){
    if(_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), (){
      getAllProfessor(search);
    });

  }

  
}
