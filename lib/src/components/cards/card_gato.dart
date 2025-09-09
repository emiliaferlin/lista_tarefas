import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/model/imagens_gatos/imagens_gatos_model.dart';

class CardGato extends StatelessWidget {
  final ImagensGatosModel? dadosGatos;

  const CardGato({super.key, this.dadosGatos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          dadosGatos?.url ?? "",
          width: double.parse(dadosGatos?.width.toString() ?? "100"),
          height: double.parse(dadosGatos?.height.toString() ?? "100"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
