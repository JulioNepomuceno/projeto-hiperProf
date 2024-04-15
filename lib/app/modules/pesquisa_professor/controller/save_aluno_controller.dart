import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hiperprof/app/data/models/aluno_model.dart';
import 'package:hiperprof/app/mixins/format_data.dart';
import 'package:hiperprof/app/modules/pesquisa_professor/services/save_alunos_service.dart';

class SaveAlunoController extends ChangeNotifier with FormatData{

  final SaveAlunoService _service = SaveAlunoService();
  final bool Function() onValidForm;
  var load = false;
  var mensageErro = '';
  var _data = '';

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final dataController = TextEditingController();

  final Future<DateTime?> Function() onOpenDataPicker;
  final Future<TimeOfDay?> Function() onOpenTimePicker;
  final VoidCallback onNavigatorPop;
  final Function() onpenScacBar;


  SaveAlunoController(
      {required this.onValidForm,
      required this.onOpenDataPicker,
      required this.onOpenTimePicker ,required this.onpenScacBar, required this.onNavigatorPop});



    Future<void> selecionaData() async {
    final dateTime = await onOpenDataPicker();
    final timeOfDay = await onOpenTimePicker();
    dataController.text = formatDataComHoraBr(dateTime: dateTime!, timeOfDay: timeOfDay!);

    _data = formatDataComHoraIso(dateTime: dateTime, timeOfDay: timeOfDay);
  }

  Future<void> contratar({required int professorId}) async {
    final isValid = onValidForm();

    if (isValid && !load) {
      load = true;
      mensageErro = '';
      notifyListeners();
      try {
        final aluno = Aluno(
            nome: nomeController.text, email: emailController.text, data: _data);

        await _service.salvarAluno(aluno: aluno, professorId: professorId);
        onpenScacBar();
        onNavigatorPop();
      } catch (e) {
        mensageErro = e.toString();
      } finally {
        load = false;
      }
    }
  }


}
