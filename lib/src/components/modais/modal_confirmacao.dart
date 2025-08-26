import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';

class ModalConfirmacao extends StatelessWidget {
  final String? title;
  final String? body;
  final String? principal;
  const ModalConfirmacao({super.key, this.body, this.principal, this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? "",
        style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.normal),
      ),
      content: Text(
        body ?? "",
        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(
            principal ?? "",
            style: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.normal,
              color: Colors.white,
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: primaryColor ?? Colors.black),
          ),
          child: Text(
            "Cancelar",
            style: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.normal,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
