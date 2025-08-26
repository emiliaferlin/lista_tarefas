import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';

class TextFormFieldComponente extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hinText;
  final Icon? icone;
  final String? Function(String?)? validator;
  const TextFormFieldComponente({
    super.key,
    this.controller,
    this.hinText,
    this.icone,
    this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(fontSize: 16.0),
      cursorErrorColor: Colors.red,
      cursorColor: primaryColor,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        icon: icone,
        labelText: labelText,
        hintText: hinText,
        hintStyle: TextStyle(color: primaryColor),
        labelStyle: TextStyle(color: Colors.black),
        focusColor: primaryColor,
        fillColor: primaryColor,
        iconColor: Colors.black,
        hoverColor: primaryColor,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor ?? Colors.black),
        ),
      ),

      validator: validator,
    );
  }
}
