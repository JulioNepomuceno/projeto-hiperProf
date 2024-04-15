import 'package:flutter/material.dart';
import 'package:hiperprof/app/components/hp_text_title.dart';
import 'package:hiperprof/app/data/models/aluno_model.dart';
import 'package:hiperprof/app/data/models/professor_model.dart';
import 'package:hiperprof/app/modules/home_professor/controller/home_professor_controller.dart';

class HomeProfessorView extends StatelessWidget {
  
  const HomeProfessorView({super.key});

  @override
  Widget build(BuildContext context) {
      final professor = ModalRoute.of(context)!.settings.arguments as Professor;
    final controller = HomeProfessorController(onNavigatePaginaInical: (route) {
      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
    }, openSnackbar: (msg) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      ));
    }, onNavigateEditar: (route ) { Navigator.pushNamed(context, route, arguments:  professor); },);

    return Scaffold(
      appBar: AppBar(),
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              onTap: controller.editarProferros,
              title: const Text('Editar'),
              leading: const Icon(Icons.edit),
            ),
            ListTile(
              onTap: controller.logout,
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
            ),
            ListTile(
              onTap: controller.acessarPaginaPrincipal,
              title: const Text('Pagina principal'),
              leading: const Icon(Icons.home),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            const HPTextTitle(text: 'Lista de aulas', size: HPSizeTitle.normal),
            FutureBuilder<List<Aluno>>(
                future: controller.getAllAlunos(),
                builder: (context, snpashot) {
                  if (snpashot.hasData) {
                    if (snpashot.data!.isEmpty) {
                      return const Center(
                        child: Text('Nenhuma aula disponivel'),
                      );
                    }
                    return AnimatedBuilder(
                        animation:controller,
                        builder: (context, child) {
                          return ExpansionPanelList(
                            expansionCallback: controller.expansionCallback,
                            children:
                                controller.itens.map<ExpansionPanel>((item) {
                              return ExpansionPanel(
                                  isExpanded: item.isExpanded,
                                  headerBuilder: (context, isExpanded) {
                                    return ListTile(
                                      title: Text(item.nome),
                                      leading: const Icon(Icons.person),
                                    );
                                  },
                                  body: Table(
                                    children: [
                                      TableRow(
                                        children: [
                                          ListTile(
                                            dense: true,
                                            title: Text(item.email),
                                            leading: const Icon(Icons.email),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          ListTile(
                                            dense: true,
                                            title: Text(item.data),
                                            leading: const Icon(Icons.school),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ));
                            }).toList(),
                          );
                        });
                  } else if (snpashot.hasError) {
                    return Center(child: Text('Erro: ${snpashot.error}'));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      )),
    );
  }
}
