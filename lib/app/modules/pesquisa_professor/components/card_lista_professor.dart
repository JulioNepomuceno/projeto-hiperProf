import 'package:flutter/material.dart';
import 'package:hiperprof/app/components/hp_text_title.dart';
import 'package:hiperprof/app/data/models/professor_model.dart';

class CardProfessor extends StatelessWidget {
  final Professor professor;
  final Function()? onTap;
  final int? maxLines;
  const CardProfessor(
      {super.key, required this.professor, this.onTap, required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(children: [
        GestureDetector(
          onTap: onTap,
          child: Visibility(
            visible: professor.fotoPerfil != null,
            replacement: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              child: const Icon(
                Icons.person,
                size: 50,
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: NetworkImage(professor.fotoPerfil ?? ''),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: HPTextTitle(text: professor.nome, size: HPSizeTitle.small),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 5),
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.attach_money,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Text(
                  'R\$${professor.valorAula}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Text(
              professor.descricao,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
            )
          ],
        )
      ]),
    );
  }
}
