import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/cards/card_tarefa.dart';
import 'package:lista_tarefa/src/database/tarefa/tarefaDao.dart';
import 'package:lista_tarefa/src/model/tarefa/tarefa_model.dart';
import 'package:lista_tarefa/src/view/tarefa/formulario_tarefa_view.dart';

class ListagemTarefasView extends StatefulWidget {
  const ListagemTarefasView({super.key});

  @override
  State<ListagemTarefasView> createState() => _ListagemTarefasViewState();
}

class _ListagemTarefasViewState extends State<ListagemTarefasView> {
  Tarefadao db = Tarefadao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Tarefas", style: TextStyle(color: Colors.white)),
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
                                updateStatus(tarefas?[index], value);
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
        child: Icon(Icons.add, color: Colors.white, size: 28.0),
      ),
    );
  }

  updateStatus(TarefasModel? taref, bool? value) {
    TarefasModel tarefa = TarefasModel(
      id: taref?.id,
      descricao: taref?.descricao,
      observacao: taref?.observacao,
      status: value == true ? 1 : 0,
    );
    db.update(tarefa);
    setState(() {});
    if (value == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tarefa Concluída!')));
    }
  }
}
