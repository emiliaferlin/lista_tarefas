import 'package:flutter/material.dart';

class TextFieldComponente extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hinText;
  final Icon? icone;
  const TextFieldComponente({
    super.key,
    this.controller,
    this.hinText,
    this.icone,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(fontSize: 16.0),
      decoration: InputDecoration(
        icon: icone,
        labelText: labelText,
        hintText: hinText,
      ),
    );
  }
}
