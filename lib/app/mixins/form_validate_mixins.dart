import 'package:validatorless/validatorless.dart';

mixin FormValidateMixin {
  final validateFormRequered = Validatorless.required('Campo obrigatorio');

  final validateFormEmail = Validatorless.multiple([
    Validatorless.required('Campo obrigatorio'),
    Validatorless.email('Email invalido')
  ]);

  final validateFormNumber = Validatorless.multiple([Validatorless.required('Campo e obrigatorio'), Validatorless.number('Somente numeros')]);

}
