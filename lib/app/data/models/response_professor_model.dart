import 'package:hiperprof/app/data/models/professor_model.dart';

class ResponseProfessor {
  String? token;
  Professor? professor;

  ResponseProfessor({this.token, this.professor});

  factory ResponseProfessor.fromJson(Map<String, dynamic> json) {
    return ResponseProfessor(
        token: json['token'],
        professor:
            json['user'] == null ? null : Professor.fromJson(json['user']));
  }

  Map<String, dynamic> toJson(){
    return {'token': token, 'user': professor?.toJson()};
  }
}
