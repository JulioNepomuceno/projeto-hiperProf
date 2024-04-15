import 'package:hiperprof/app/data/models/professor_model.dart';

class CadastroProfessor extends Professor {
  final String password, passwordConfirm;

  CadastroProfessor({
    required super.nome,
    required super.descricao,
    required super.email,
    required super.valorAula,
    required super.idade,
    required this.password,
    required this.passwordConfirm,
    super.fotoPerfil,
    super.id,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'idade': idade,
      'valor_aula': valorAula,
      'descricao':descricao,
      'email':email,
      'id':id,
      'password':password,
      'password_confirmation':passwordConfirm
    };
  }
}
