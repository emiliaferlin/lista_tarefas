import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/card_lista_tarefas.dart';
import 'package:lista_tarefa/src/model/lista_tarefas_model.dart';
import 'package:lista_tarefa/src/view/formulario_tarefa_view.dart';

class ListaTarefasView extends StatefulWidget {
  const ListaTarefasView({super.key});

  @override
  State<ListaTarefasView> createState() => _ListaTarefasViewState();
}

class _ListaTarefasViewState extends State<ListaTarefasView> {
  List<ListaTarefasModel> tarefas = [];
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
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 8.0),
                itemCount: tarefas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      tarefas.remove(tarefas[index]);
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: const Text('Tarefa Excluída!')),
                      );
                    },
                    child: CardListaTarefas(dadosTarefa: tarefas[index]),
                  );
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
                return FormularioTarefaView();
              },
            ),
          ).then((value) {
            if (value is ListaTarefasModel) {
              tarefas.add(value);
              setState(() {});
            }
          });
        },
        child: Icon(Icons.add_task_outlined, color: Colors.white, size: 28.0),
      ),
    );
  }
}
