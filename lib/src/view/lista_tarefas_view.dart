import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/cards/card_tarefa.dart';
import 'package:lista_tarefa/src/database/tarefaDao.dart';
import 'package:lista_tarefa/src/model/tarefa_model.dart';
import 'package:lista_tarefa/src/view/formulario_tarefa_view.dart';

class ListaTarefasView extends StatefulWidget {
  const ListaTarefasView({super.key});

  @override
  State<ListaTarefasView> createState() => _ListaTarefasViewState();
}

class _ListaTarefasViewState extends State<ListaTarefasView> {
  Tarefadao db = Tarefadao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Lista de Tarefas", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<TarefasModel>>(
                initialData: [],
                future: db.findAll(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.data != null) {
                        List<TarefasModel>? tarefas = snapshot.data;
                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          itemCount: tarefas?.length,
                          itemBuilder: (context, index) {
                            return CardTarefa(
                              dadosTarefa: tarefas?[index],
                              db: db,
                              onChangedCheckBox: (value) {
                                TarefasModel tarefa = TarefasModel(
                                  id: tarefas?[index].id,
                                  descricao: tarefas?[index].descricao,
                                  observacao: tarefas?[index].observacao,
                                  status: value == true ? 1 : 0,
                                );
                                db.update(tarefa);
                                setState(() {});
                                if (value == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Tarefa Concluída!'),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        );
                      } else {
                        return Center(child: Text("Carregando os dados..."));
                      }
                    default:
                      return Center(child: Text("Carregando os dados..."));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTarefaView(isNovatarefa: true);
              },
            ),
          );
        },
        child: Icon(Icons.add_task_outlined, color: Colors.white, size: 28.0),
      ),
    );
  }
}
