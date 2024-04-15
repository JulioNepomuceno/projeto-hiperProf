import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiperprof/app/components/hp_elevated_button.dart';
import 'package:hiperprof/app/components/hp_outlined_button.dart';
import 'package:hiperprof/app/components/hp_text_area.dart';
import 'package:hiperprof/app/components/hp_text_form_field.dart';
import 'package:hiperprof/app/components/hp_text_title.dart';
import 'package:hiperprof/app/data/models/professor_model.dart';
import 'package:hiperprof/app/mixins/form_validate_mixins.dart';
import 'package:hiperprof/app/modules/formulario_professor/components/foto_floatactionbutton.dart';

import '../controller/formulario_controller.dart';

class FormularioProfessorView extends StatefulWidget {
  final Professor? professor;
  const FormularioProfessorView({super.key, required this.professor});

  @override
  State<FormularioProfessorView> createState() =>
      _FormularioProfessorViewState();
}

class _FormularioProfessorViewState extends State<FormularioProfessorView>
    with FormValidateMixin {
  final key = GlobalKey<FormState>();
  late final controller = FormularioController(
      isValidForm: () => key.currentState?.validate() ?? false,
      onOpenSnackBar: (erroMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(erroMessage),
          action: SnackBarAction(label: 'Ok', onPressed: () {}),
          duration: const Duration(seconds: 30),
        ));
      },
      onNavigator: (route, novoProfessor) {
        Navigator.pushNamedAndRemoveUntil(
            context, route, arguments: novoProfessor, (route) => false);
      },
      openDialog: (controller) {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  child: Container(
                height: 210,
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                child: Column(
                  children: [
                    HPTextTitle(
                        text: 'Tem certeza que deseja apaga sua conta?',
                        size: HPSizeTitle.small),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                        'Ao apagar sua conta, tambem sera excluido todo o historico de aula'),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(children: [
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context), child: Text('Nao apagar')),
                            const Spacer(),
                        OutlinedButton( onPressed: controller.apagarConta, style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Theme.of(context).errorColor),), child: Text('Apagar'),) 
                      ]),
                    )
                  ],
                ),
              ));
            });
      });

  @override
  void dispose() {
    controller.nomeController.dispose();
    controller.idadeController.dispose();
    controller.valorAulaController.dispose();
    controller.emailController.dispose();
    controller.senhaController.dispose();
    controller.confirmarSenhaController.dispose();
    controller.descricaoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller.inicialProfessor(widget.professor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 3),
      floatingActionButton: Visibility(
        visible: widget.professor != null,
        child: FloatingActionButton(
          onPressed: controller.opoenCam,
          shape: UnderlineInputBorder(borderRadius: BorderRadius.circular(50)),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, snapshot) {
              return FotoFloatActionButton(img: controller.image);
            }
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 60, right: 60),
          child: Form(
              key: key,
              child: Column(
                children: [
                  HPTextTitle(
                      text: 'Dados de cadastro', size: HPSizeTitle.normal),
                  HPTextFormField(
                    validator: validateFormRequered,
                    controller: controller.nomeController,
                    label: 'Nome',
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  HPTextFormField(
                    validator: validateFormNumber,
                    controller: controller.idadeController,
                    label: 'Idade',
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  HPTextFormField(
                    validator: validateFormRequered,
                    controller: controller.valorAulaController,
                    label: 'Valor da aula',
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  HPTextFormField(
                    validator: validateFormEmail,
                    controller: controller.emailController,
                    label: 'Email',
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  HPTextFormField(
                    validator: controller.validSenha,
                    controller: controller.senhaController,
                    label: 'Senha',
                    obscureText: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  HPTextFormField(
                    validator: controller.validSenha,
                    controller: controller.confirmarSenhaController,
                    label: 'Confirmar senha',
                    obscureText: true,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  HPTextArea(
                    validator: validateFormRequered,
                    label: 'Descricao',
                    controller: controller.descricaoController,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return HPElevatedButton(
                          padding: EdgeInsets.only(
                              top: 50, bottom: 20, right: 60, left: 60),
                          onPressed: controller.salvaConta,
                          child: Visibility(
                            visible: !controller.load,
                            replacement: const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            child:  Visibility(
                                visible: widget.professor ==null,
                                replacement: Text('Editar conta'),
                                child: Text('Cadastrar conta')),
                          ),
                        );
                      })
                ],
              )),
        ),
        Visibility(
            visible: widget.professor != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: HPTextTitle(
                    text:
                        'Voce pode apaga sua conta, desse modo nao sera mais exibido na plataforma',
                    size: HPSizeTitle.small,
                  ),
                ),
                HPOutlinedButton(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  onPressed: controller.openModal,
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          Theme.of(context).errorColor)),
                  child: Text('Apagar minha conta'),
                ),
              ]),
            ))
      ]),
    );
  }
}
