import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/model/lista_tarefas_model.dart';

class CardListaTarefas extends StatelessWidget {
  final ListaTarefasModel? dadosTarefa;
  const CardListaTarefas({super.key, this.dadosTarefa});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(Icons.task_alt_outlined),
            Expanded(
              child: Column(
                children: [
                  Text(dadosTarefa?.descricao ?? ""),
                  Text(dadosTarefa?.observacao ?? ""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
