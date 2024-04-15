import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hiperprof/app/data/models/response_professor_model.dart';

class Storage{

  final _getStorage = GetStorage();

  Future<void> saveToken(ResponseProfessor responseProfessor) async{
    await _getStorage.write('auth', responseProfessor.toJson());
  }

  ResponseProfessor? getToken(){
    final res = _getStorage.read('auth');
    
    if(res != null){
      return ResponseProfessor.fromJson(res);
    }
    return null;
  }

  void clearToken(){
    _getStorage.remove('auth');
  }
}