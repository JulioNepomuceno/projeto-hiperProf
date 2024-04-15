import 'package:flutter/cupertino.dart';
import 'package:hiperprof/app/data/models/aluno_model.dart';
import 'package:hiperprof/app/modules/home_professor/models/item_model.dart';
import 'package:hiperprof/app/modules/home_professor/service/home_professor_service.dart';
import 'package:hiperprof/routes.dart';

import '../../../mixins/format_data.dart';

class HomeProfessorController extends ChangeNotifier with FormatData {
  final HomeProfessorService _service = HomeProfessorService();
  var itens = const <ItemModel>[];

  final void Function(String) onNavigatePaginaInical;
  final void Function(String) openSnackbar;
  final void Function(String) onNavigateEditar;


  HomeProfessorController({required this.onNavigatePaginaInical, required this.openSnackbar, required this.onNavigateEditar});

  void editarProferros() {
    onNavigateEditar(Routes.FORMULARIO_PROFESSOR);
  }

  void acessarPaginaPrincipal() {
    onNavigatePaginaInical(Routes.INICIAL);
  }

  Future<void> logout() async {
    try {
      await _service.logout();
      onNavigatePaginaInical(Routes.INICIAL);
    } catch (e) {
      openSnackbar(e.toString());
    }
  }

  void expansionCallback(int index, bool isExpanded) {
    itens[index].isExpanded = !isExpanded;
    notifyListeners();
  }

  Future<List<Aluno>> getAllAlunos() async {
    try {
      final alunos = await _service.getAlunos();
      itens = alunos
          .map((aluno) => ItemModel(
                nome: aluno.nome,
                email: aluno.email,
                data: formatarDataStringParaBr(aluno.data),
              ))
          .toList();

      return alunos;
    } catch (erro) {
      rethrow;
    }
  }
}
