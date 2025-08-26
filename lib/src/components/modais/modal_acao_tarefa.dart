import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/modais/modal_confirmacao.dart';
import 'package:lista_tarefa/src/database/tarefaDao.dart';
import 'package:lista_tarefa/src/model/tarefa_model.dart';
import 'package:lista_tarefa/src/view/formulario_tarefa_view.dart';
import 'package:lista_tarefa/src/view/lista_tarefas_view.dart';

void acaoTarefaModalBottomSheet(context, TarefasModel tarefa, Tarefadao db) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Editar'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FormularioTarefaView(
                          tarefa: tarefa,
                          isNovatarefa: false,
                        );
                      },
                    ),
                    (route) => false,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outline_outlined),
                title: Text('Excluir'),
                onTap: () async {
                  Navigator.pop(context);
                  await showDialog(
                    context:
                        context, // O contexto necessário para exibir o diálogo
                    builder: (BuildContext context) {
                      return ModalConfirmacao(
                        title:
                            'Deseja excluir essa tarefa ${tarefa.descricao}?',
                        body:
                            'Após a exclusão, essa tarefa não será mais exibida para você. ',
                        principal: "Excluir",
                      );
                    },
                  ).then((value) {
                    if (value == true) {
                      db.delete(tarefa.id ?? 0);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ListaTarefasView();
                          },
                        ),
                        (route) => false,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text('Tarefa Excluída!')),
                      );
                    }
                  });
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
