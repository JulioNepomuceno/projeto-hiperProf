import 'package:dio/dio.dart';
import 'package:hiperprof/app/data/provider/client_api.dart';
import 'package:hiperprof/app/data/storage/auth.dart';

class ProfessorRepository{
  final ApiClient _apiClient = ApiClient();

  Future<Response<T>> getAll<T>(String? search) async{
     return await _apiClient.get('/professores', query:{'q':search});
  }

  Future<Response<T>> sava<T>({required Map<String, dynamic> data, int? id}) async{
    if(id == null){
      return await _apiClient.post('/professores', data: data);
    }

    return await _apiClient.put('/professores', data: data);
  }

    Future<Response<T>> saveFotoProfessor<T>(
      {required image, required int professorId}) async {
    final responseProfessor = Storage().getToken();

    final header = {
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
      "Authorization": 'Bearer ${responseProfessor?.token}',
    };

    return await _apiClient.post('/professores/$professorId/foto',
        data: image, headers: header);
  }

  Future<Response<T>> delete<T>() async {
    return await _apiClient.delete('/professores');
  }
  
}