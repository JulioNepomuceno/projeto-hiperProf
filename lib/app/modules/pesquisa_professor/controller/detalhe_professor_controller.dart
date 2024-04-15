import 'package:flutter/material.dart';

class DetalheProfessorController extends ChangeNotifier{

  final Function(DetalheProfessorController) onOpenModalForm;
 


  DetalheProfessorController( {required this.onOpenModalForm});

  void contratarProfessor(){
    onOpenModalForm(this);
  }

  

}

