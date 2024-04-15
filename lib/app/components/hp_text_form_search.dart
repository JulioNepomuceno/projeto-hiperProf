import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hiperprof/app/components/hp_text_form_field.dart';

class HPTextFormSearch extends StatelessWidget {
  
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;
  final String? initialValue;
  final String? label;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  const HPTextFormSearch(
      {super.key,
      this.padding,
      this.controller,
      this.initialValue,
      this.label,
      this.onChanged,
      this.validator,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return HPTextFormField(
      padding: padding,
      controller: controller,
      initialValue: initialValue,
      label: label,
      onChanged: onChanged,
      validator: validator,
      inputFormatters: inputFormatters,
      suffix: const Icon(Icons.search),
    );
  }
}
