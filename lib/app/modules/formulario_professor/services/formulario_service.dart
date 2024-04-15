import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hiperprof/app/data/models/professor_model.dart';
import 'package:hiperprof/app/data/repositories/professor_repository.dart';
import 'package:hiperprof/app/data/storage/auth.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/response_professor_model.dart';

class FormularioProfessorSerivece {
  final ProfessorRepository _professorRepository = ProfessorRepository();
  final Storage _storage = Storage();

  Future<Professor> cadastrarProfessor(Professor professor) async {
    try {
      final response =
          await _professorRepository.sava(data: professor.toJson());

      final professsoResponse = ResponseProfessor.fromJson(response.data);
      _storage.saveToken(professsoResponse);
      return professsoResponse.professor!;
    } on DioError catch (erro, s) {
      log('Erro ao salvar professro', error: erro, stackTrace: s);

      if (erro.response != null) {
        throw erro.response!.data['message'];
      }
      throw 'Erro ao salvar professor';
    } catch (e) {
      throw 'Erro ao salvar professor';
    }
  }

Future<String> salvarImagemProfessor(
      {required XFile path, required int professorId}) async {
    try {
      final multiPardata =
          await MultipartFile.fromFile(path.path, filename: path.name);

      final form = FormData.fromMap({'foto': multiPardata});

      final response = await _professorRepository.saveFotoProfessor(
        image: form,
        professorId: professorId,
      );

      final professorEditado = Professor.fromJson(response.data);

      final token = _storage.getToken()!.token;
      _storage.saveToken(
          ResponseProfessor(professor: professorEditado, token: token));

      return professorEditado.fotoPerfil!;
    } on DioError catch (erro, s) {
      log('Erro ao salvar foto', error: erro, stackTrace: s);

      if (erro.response != null) {
        throw erro.response!.data['message'];
      }
      throw 'Erro ao salvar foto';
    } catch (e) {
      throw 'Erro inesperado ao salvar foto';
    }
  }

  Future<Professor> editarProfessor(Professor professor) async {
    try {
      final response = await _professorRepository.sava(
        data: professor.toJson(),
        id: professor.id,
      );

      final professorEditado = Professor.fromJson(response.data);
      final token = _storage.getToken()!.token;
      _storage.saveToken(
          ResponseProfessor(professor: professorEditado, token: token));

      return professorEditado;
    } on DioError catch (erro, s) {
      log('Erro ao editar professor', error: erro, stackTrace: s);

      if (erro.response != null) {
        throw erro.response!.data['message'];
      }
      throw 'Erro ao editar professor';
    } catch (e) {
      throw 'Erro ao editar professor';
    }
  }

  Future<void> deletarProfessor() async {
    try {
      await _professorRepository.delete();
      _storage.clearToken();
    } on DioError catch (erro, s) {
      log('Erro ao deletar professor', error: erro, stackTrace: s);

      if (erro.response != null) {
        throw erro.response!.data['message'];
      }
      throw 'Erro ao deletar professor';
    } catch (e) {
      throw 'Erro ao deletar professor';
    }
  }
}
