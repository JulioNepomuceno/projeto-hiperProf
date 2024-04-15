// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hiperprof/app/data/models/professor_model.dart';
import 'package:hiperprof/app/data/repositories/professor_repository.dart';

class PesquisaProfessorSerivice {
  final ProfessorRepository _professorRepository = ProfessorRepository();

  Future<List<Professor>> getAllProfessores(String? search) async {
    try {
      final response = await _professorRepository.getAll(search);
      final professores = (response.data as List).map((json) => Professor.fromJson(json)).toList();

      return professores;


    } on DioError catch (erro, s) {
      log('Erro ao buscar professores', error: erro, stackTrace: s);
      if (erro.response != null) {
        throw erro.response!.data['menssage'];
      }
      throw 'Erro ao buscar professores';
    } catch (erro,s) {
      log('Erro ao buscar professores', error: erro, stackTrace: s);

      throw 'Error ao buscar professores';
    }
  }
}
