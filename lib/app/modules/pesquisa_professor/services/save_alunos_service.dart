import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hiperprof/app/data/models/aluno_model.dart';
import 'package:hiperprof/app/data/repositories/aluno_repository.dart';

class SaveAlunoService {
  final AlunosRepository _alunosRepository = AlunosRepository();



   Future<void> salvarAluno(
      {required Aluno aluno, required int professorId}) async {
    try {
      await _alunosRepository.save(
          data: aluno.toJson(), professorId: professorId);
    } on DioError catch (erro, s) {
      log("Erro ao salvar aluno", error: erro, stackTrace: s);
      if (erro.response != null) {
        throw erro.response!.data['message'];
      }
      throw "Erro ao salvar aluno";
    } catch (erro, s) {
      log("Erro ao salvar aluno", error: erro, stackTrace: s);
      throw "Erro ao salvar aluno";
    }
  }
}
