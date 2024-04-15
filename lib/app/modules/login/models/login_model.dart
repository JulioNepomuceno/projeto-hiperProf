class LoginModel {
  String email, password, dispositivo;

  LoginModel({
    required this.email,
    required this.password,
    required this.dispositivo,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'dispositivo': dispositivo,
    };
  }
}