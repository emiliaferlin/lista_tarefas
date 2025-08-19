import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/text_field.dart';
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Adicionar Tarefa", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldComponente(
                  controller: tarefaText,
                  icone: Icon(Icons.task_outlined),
                  labelText: "Tarefa",
                  hinText: "Informe a tarefa",
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextFieldComponente(
                    controller: observacaoText,
                    icone: Icon(Icons.article_outlined),
                    labelText: "Observação",
                    hinText: "Informe a observação da tarefa",
                  ),
                ),
              ],
            ),
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
