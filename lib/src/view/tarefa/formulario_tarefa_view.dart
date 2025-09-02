import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/fields/text_form_field.dart';
import 'package:lista_tarefa/src/components/navigation_bar/navigation_bar.dart';
import 'package:lista_tarefa/src/database/tarefa/tarefaDao.dart';
import 'package:lista_tarefa/src/model/tarefa/tarefa_model.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';

class FormularioTarefaView extends StatefulWidget {
  final TarefasModel? tarefa;
  final bool isNovatarefa;
  const FormularioTarefaView({
    super.key,
    this.tarefa,
    required this.isNovatarefa,
  });

  @override
  State<FormularioTarefaView> createState() => _FormularioTarefaViewState();
}

class _FormularioTarefaViewState extends State<FormularioTarefaView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController tarefaText = TextEditingController();
  TextEditingController observacaoText = TextEditingController();
  Tarefadao db = Tarefadao();
  TarefasModel tarefa = TarefasModel();

  @override
  void initState() {
    if (widget.isNovatarefa == false &&
        widget.tarefa?.id != null &&
        widget.tarefa?.descricao != null) {
      tarefaText.text = widget.tarefa?.descricao ?? "";
      observacaoText.text = widget.tarefa?.observacao ?? "";
      setState(() {});
    }
    super.initState();
  }

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
                TextFormFieldComponente(
                  controller: tarefaText,
                  icone: Icon(Icons.task_outlined),
                  labelText: "Tarefa",
                  hinText: "Informe a tarefa",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo obrigatório";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextFormFieldComponente(
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
          onPressed: () async {
            if (_formKey.currentState?.validate() == true) {
              if (widget.isNovatarefa == false &&
                  widget.tarefa?.id != null &&
                  widget.tarefa?.descricao != null) {
                await updateTarefa();
              } else {
                await addTarefa();
              }
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BottomNavigationBarApp(indexPage: 0);
                  },
                ),
                (route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    widget.isNovatarefa == true
                        ? 'Tarefa Adicionada!'
                        : 'Tarefa Editada!',
                  ),
                ),
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

  updateTarefa() {
    tarefa = TarefasModel(
      id: widget.tarefa?.id,
      descricao: tarefaText.text,
      observacao: observacaoText.text,
      status: widget.tarefa?.status,
    );
    db.update(tarefa);
  }

  addTarefa() {
    tarefa = TarefasModel(
      id: 1,
      descricao: tarefaText.text,
      observacao: observacaoText.text,
      status: 0,
    );
    db.add(tarefa);
  }
}
