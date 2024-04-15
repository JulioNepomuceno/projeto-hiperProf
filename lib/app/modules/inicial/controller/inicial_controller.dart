import 'package:flutter/material.dart';
import 'package:hiperprof/app/data/storage/auth.dart';
import 'package:hiperprof/routes.dart';

class InicialController {


  final bool Function() isValidForm;
  final Function(String route, Object? search) onNavigatiorProfessor;
  final searchController = TextEditingController();

  InicialController({required this.isValidForm, required this.onNavigatiorProfessor});

  String? validateSarch(String? value) {
    if (value?.isEmpty ?? true) {
      return 'Digite o que deseja aprender';
    }

    return null;
  }

  void buscarProfessor() {
    final isValid = isValidForm();

    if(isValid){
      onNavigatiorProfessor(Routes.PESQUISA_PROFESSOR, searchController.text);
    }
  }

  void sejaProfessor() {
    onNavigatiorProfessor(Routes.FORMULARIO_PROFESSOR, null);
  }

  void consultarAula() {
    final professorResponse = Storage().getToken();

    if(professorResponse != null){
      onNavigatiorProfessor(Routes.HOME_PROFESSOR,professorResponse.professor!);
    }else{
     onNavigatiorProfessor(Routes.LOGIN, null);
    }

  }
}
