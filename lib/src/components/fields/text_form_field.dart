import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';

class TextFormFieldComponente extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hinText;
  final Icon? icone;
  final String? Function(String?)? validator;
  final bool? enable;
  final List<TextInputFormatter>? textInputFormatter;
  const TextFormFieldComponente({
    super.key,
    this.controller,
    this.hinText,
    this.icone,
    this.labelText,
    this.validator,
    this.enable,
    this.textInputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
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
        enabled: enable ?? true,
        inputFormatters: textInputFormatter,
        validator: validator,
      ),
    );
  }
}
