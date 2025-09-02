import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/database/tarefa/tarefaDao.dart';
import 'package:lista_tarefa/src/model/tarefa/tarefa_model.dart';
import 'package:lista_tarefa/src/components/modais/modal_acao_tarefa.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';

class CardTarefa extends StatelessWidget {
  final TarefasModel? dadosTarefa;
  final Tarefadao? db;
  final Function(bool?)? onChangedCheckBox;
  const CardTarefa({
    super.key,
    this.dadosTarefa,
    this.db,
    this.onChangedCheckBox,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Checkbox(
                    value: dadosTarefa?.status == 0 ? false : true,
                    activeColor: primaryColor,
                    onChanged: onChangedCheckBox,
                  ),
                  SizedBox(width: 12.0),
                  Column(
                    children: [
                      Text(dadosTarefa?.descricao ?? ""),
                      Text(dadosTarefa?.observacao ?? ""),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                acaoTarefaModalBottomSheet(
                  context,
                  dadosTarefa ?? TarefasModel(),
                  db ?? Tarefadao(),
                );
              },
              icon: Icon(Icons.edit_note_outlined, size: 42.0),
            ),
          ],
        ),
      ),
    );
  }
}
