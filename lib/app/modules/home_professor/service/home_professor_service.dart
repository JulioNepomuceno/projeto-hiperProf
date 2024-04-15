import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hiperprof/app/data/models/aluno_model.dart';
import 'package:hiperprof/app/data/repositories/aluno_repository.dart';
import 'package:hiperprof/app/data/repositories/auth_repository.dart';
import 'package:hiperprof/app/data/storage/auth.dart';

class HomeProfessorService {
  final AlunosRepository _alunosRepository = AlunosRepository();
  final AuthRepository _authRepository = AuthRepository();
  final Storage _storage = Storage();

  Future<List<Aluno>> getAlunos() async {
    try {
      final response = await _alunosRepository.getAlunos();
      return (response.data as List)
          .map((json) => Aluno.fromJson(json))
          .toList();
    } on DioError catch (erro, s) {
      log('Erro ao buscar alunos', error: erro, stackTrace: s);

      if (erro.response != null) {
        throw erro.response!.data['message'];
      }
      throw 'Erro ao Buscar alunos';
    } catch (e, s) {
      log('Erro ao buscar alunos', error: e, stackTrace: s);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      _storage.clearToken();
    } on DioError catch (erro, s) {
      log('Erro ao fazer logout', error: erro, stackTrace: s);

      if (erro.response != null) {
        throw erro.response!.data['message'];
      }
      throw 'Erro ao fazer logout';
    } catch (e, s) {
      log('Erro  inesperado ao fazer logout', error: e, stackTrace: s);
      rethrow;
    }
  }
}
