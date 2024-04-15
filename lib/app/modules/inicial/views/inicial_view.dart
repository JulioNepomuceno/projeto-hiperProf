import 'package:flutter/material.dart';
import 'package:hiperprof/app/components/hp_elevated_button.dart';
import 'package:hiperprof/app/components/hp_outlined_button.dart';
import 'package:hiperprof/app/components/hp_text_form_search.dart';
import 'package:hiperprof/app/components/hp_text_title.dart';
import 'package:hiperprof/app/modules/inicial/controller/inicial_controller.dart';

class InicialView extends StatefulWidget {
  const InicialView({super.key});

  @override
  State<InicialView> createState() => _InicialViewState();
}

class _InicialViewState extends State<InicialView> {
  final _key = GlobalKey<FormState>();
  late final _mediaQuery = MediaQuery.of(context);
  late final controller = InicialController(
      isValidForm: () => _key.currentState?.validate() ?? false,
      onNavigatiorProfessor: (route, search) =>
          Navigator.pushNamed(context, route, arguments: search));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: _mediaQuery.size.height - _mediaQuery.padding.top,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        const HPTextTitle(
                          text: 'ENCONTRE O PROFESSOR IDEAL PARA VOCÊ !',
                          size: HPSizeTitle.large,
                        ),
                        HPTextFormSearch(
                          validator: controller.validateSarch,
                          controller: controller.searchController,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                        ),
                        HPElevatedButton(
                          onPressed: controller.buscarProfessor,
                          child: Text('Buscar o professor'),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 60, right: 60, bottom: 20),
                  child: Column(
                    children: [
                      HPElevatedButton(
                        onPressed: controller.sejaProfessor,
                        child: const Text('Seja um professor'),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColorLight),
                      ),
                      HPOutlinedButton(
                        onPressed: controller.consultarAula,
                        child: const Text('Consultar minhas aulas'),
                      )
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
