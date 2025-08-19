import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/model/lista_tarefas_model.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';

class FormularioTarefaView extends StatefulWidget {
  const FormularioTarefaView({super.key});

  @override
  State<FormularioTarefaView> createState() => _FormularioTarefaViewState();
}

class _FormularioTarefaViewState extends State<FormularioTarefaView> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController tarefaText = TextEditingController();
  TextEditingController observacaoText = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Tarefa", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: tarefaText,
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  icon: Icon(Icons.task_outlined),
                  labelText: "Tarefa",
                  hintText: "Informe a tarefa",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: TextField(
                  controller: observacaoText,
                  style: TextStyle(fontSize: 16.0),
                  decoration: InputDecoration(
                    icon: Icon(Icons.article_outlined),
                    labelText: "Observação",
                    hintText: "Informe a observação da tarefa",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          onPressed: () {
            if (tarefaText.text.isNotEmpty) {
              ListaTarefasModel tarefa = ListaTarefasModel(
                id: 1,
                descricao: tarefaText.text,
                observacao: observacaoText.text,
                status: 0,
              );
              Navigator.pop(context, tarefa);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('Tarefa Adicionada!')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('Escreva a sua tarefa antes!')),
              );
            }
          },
          label: Text(
            "Salvar Tarefa",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          icon: Icon(Icons.check, color: Colors.white, size: 24.0),
        ),
      ),
    );
  }
}
