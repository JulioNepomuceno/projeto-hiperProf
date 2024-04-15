import 'package:flutter/material.dart';
import 'package:hiperprof/app/components/hp_elevated_button.dart';
import 'package:hiperprof/app/components/hp_text_form_field.dart';
import 'package:hiperprof/app/components/hp_text_title.dart';
import 'package:hiperprof/app/mixins/form_validate_mixins.dart';
import 'package:hiperprof/app/modules/login/controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with FormValidateMixin {
  final key = GlobalKey<FormState>();

  late final controller = LoginController(
    onNavigate: (route, {professor, replace = true}) {
      if (replace) {
        Navigator.pushNamedAndRemoveUntil(
            context, route, arguments: professor, (route) => false);
      } else {
        Navigator.pushNamed(context, route);
      }
    },
    isValidForm: () => key.currentState?.validate() ?? false,
  );

  @override
  void dispose() {
    controller.emailController.dispose();
    controller.senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              const HPTextTitle(
                text: 'Consultar minhas aulas ',
                size: HPSizeTitle.normal,
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Form(
                  key: key,
                  child: Column(
                    children: [
                      HPTextFormField(
                        controller: controller.emailController,
                        label: 'Email',
                        validator: validateFormEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HPTextFormField(
                        controller: controller.senhaController,
                        label: 'Senha',
                        validator: validateFormRequered,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      AnimatedBuilder(
                        animation: controller.erroMessage,
                        builder: (context, child) {
                          return Visibility(
                            visible: controller.erroMessage.value != '',
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                controller.erroMessage.value,
                                style: TextStyle(
                                  color: Theme.of(context).errorColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: controller.acessCadastro,
                          child: const Text('Cadastrar'),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: controller.load,
                        builder: (context, child) {
                          return HPElevatedButton(
                            onPressed: controller.login,
                            child: Visibility(
                              visible: !controller.load.value,
                              replacement: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                              child: const Text('Acessar'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}