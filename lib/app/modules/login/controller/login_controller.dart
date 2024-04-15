import 'package:flutter/cupertino.dart';
import 'package:hiperprof/app/data/models/professor_model.dart';
import 'package:hiperprof/app/modules/login/models/login_model.dart';
import 'package:hiperprof/app/modules/login/service/login_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hiperprof/routes.dart';



class LoginController {
  final LoginService _service = LoginService();
  final _deviceInfoPlugin = DeviceInfoPlugin();

  final void Function(String, {bool replace, Professor? professor}) onNavigate;
  final bool Function() isValidForm;

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final load = ValueNotifier(false);
  final erroMessage = ValueNotifier('');

  LoginController({required this.onNavigate, required this.isValidForm});

  void acessCadastro() {
    onNavigate(Routes.FORMULARIO_PROFESSOR, replace: false);
  }

  Future<String> _getDevice() async {
    final deviceInfo = await _deviceInfoPlugin.deviceInfo;
    final deviceInfoMap = deviceInfo.toMap();
    final androidId = deviceInfoMap['id'];

    return androidId;
  }

  Future<void> login() async {
    final isValid = isValidForm();
    if (!load.value && isValid) {
      load.value = true;
      erroMessage.value = '';
      try {
        final loginModel = LoginModel(
          email: emailController.text,
          password: senhaController.text,
          dispositivo: await _getDevice(),
        );

        final professor = await _service.login(loginModel);
        onNavigate(Routes.HOME_PROFESSOR, professor: professor, replace: true);
      } catch (e) {
        erroMessage.value = e.toString();
      } finally {
        load.value = false;
      }
    }
  }
}