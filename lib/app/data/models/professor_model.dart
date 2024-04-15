class Professor {
  String nome, descricao, email;
  double valorAula;
  int? id;
  int idade;
  String? fotoPerfil;

  Professor(
      {required this.nome,
      required this.descricao,
      required this.email,
      required this.valorAula,
      required this.idade,
      this.id,
      this.fotoPerfil});

  factory Professor.fromJson(Map<String, dynamic> json) {
    return Professor(
        nome: json['nome'],
        descricao: json['descricao'],
        email: json['email'],
        valorAula: double.parse(json['valor_aula'].toString()),
        idade: json['idade'],
        fotoPerfil: json['foto_perfil'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'idade': idade,
      'valor_aula': valorAula,
      'descricao': descricao,
      'id': id,
      'email': email,
      'foto_perfil': fotoPerfil
    };
  }
}
