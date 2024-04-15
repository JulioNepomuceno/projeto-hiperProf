import 'package:dio/dio.dart';

abstract class Rest {

Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query});

Future<Response<T>> post <T>(String path, {required data});

Future<Response<T>> delete <T>(String path);

Future<Response<T>> put <T>(String path, {required data});


}