import 'package:dio/dio.dart';
import 'package:hiperprof/app/data/provider/rest_interface.dart';
import 'package:hiperprof/app/data/storage/auth.dart';

class ApiClient implements Rest{

  final Dio _dio =Dio();
  final _baseUrl = "https://alunos.treinaweb.com.br/hyperprof2/api";


  ApiClient(){
    _dio.options.baseUrl = _baseUrl;
    _dio.options.sendTimeout = const Duration(milliseconds: 15000);
    final responseProfessor = Storage().getToken();
    final header = {
      'Content-Type':'application/json',
      'Accept':'application/json',
      'Authorization': 'Bearer ${responseProfessor?.token}'
    };

    _dio.options.headers = header;
  }

  @override
  Future<Response<T>> delete<T>(String path) async {
    return await _dio.delete(path);
  }

  @override
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) async {
    return await _dio.get(path, queryParameters: query);
  }

  @override
  Future<Response<T>> post<T>(String path, {required data,Map<String, dynamic>? headers}) async {
    return await _dio.post(path,data:data, options:  Options(headers: headers));
  }

  @override
  Future<Response<T>> put<T>(String path, {required data}) async{
    return await _dio.put(path, data: data);
  }

}