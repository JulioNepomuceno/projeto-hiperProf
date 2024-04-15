import 'package:flutter/material.dart';

class HPOutlinedButton extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;
  final ButtonStyle? style;

  const HPOutlinedButton({
    super.key,
    required this.child,
    this.padding,
    required this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: padding,
      child: OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: child,
      ),
    );
  }
}
