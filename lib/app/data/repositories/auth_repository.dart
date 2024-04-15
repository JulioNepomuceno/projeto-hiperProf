import 'package:dio/dio.dart';
import 'package:hiperprof/app/data/provider/client_api.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Response<T>> postLogin<T>(Map<String, dynamic> data) async {
    return await _apiClient.post('/auth/login', data: data);
  }


  Future<Response<T>> logout<T>() async {
    return await _apiClient.delete('/auth/logout');
  }
}