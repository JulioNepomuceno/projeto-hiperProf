import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hiperprof/app/data/models/professor_model.dart';
import 'package:hiperprof/app/data/models/response_professor_model.dart';
import 'package:hiperprof/app/data/repositories/auth_repository.dart';
import 'package:hiperprof/app/data/storage/auth.dart';

import 'package:hiperprof/app/modules/login/models/login_model.dart';


class LoginService {
  final AuthRepository _authRepository = AuthRepository();

  final Storage _storage = Storage();

  Future<Professor> login(LoginModel loginModel) async {
    try {
      final response = await _authRepository.postLogin(loginModel.toJson());
      final responseModel = ResponseProfessor.fromJson(response.data);
      _storage.saveToken(responseModel);
      return responseModel.professor!;
    } on DioError catch (erro, s) {
      log('ERRO AO FAZER LOGIN', error: erro, stackTrace: s);

      if (erro.response != null) {
        throw erro.response!.data['message'];
      }
      throw 'Erro ao fazer login';
    } catch (e) {
      rethrow;
    }
  }
}