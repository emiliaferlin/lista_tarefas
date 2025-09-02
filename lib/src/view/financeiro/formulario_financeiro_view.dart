import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/fields/text_form_field.dart';
import 'package:lista_tarefa/src/components/navigation_bar/navigation_bar.dart';
import 'package:lista_tarefa/src/database/financeiro/financeiroDao.dart';
import 'package:lista_tarefa/src/model/financeiro/financeiro_model.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';

class FormularioFinanceiroView extends StatefulWidget {
  final FinanceiroModel? financeiroModel;
  final bool isNovaDespesaReceita;
  const FormularioFinanceiroView({
    super.key,
    this.financeiroModel,
    required this.isNovaDespesaReceita,
  });

  @override
  State<FormularioFinanceiroView> createState() =>
      _FormularioFinanceiroViewState();
}

class _FormularioFinanceiroViewState extends State<FormularioFinanceiroView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController descricaoText = TextEditingController();
  Financeirodao db = Financeirodao();
  FinanceiroModel financAux = FinanceiroModel();

  @override
  void initState() {
    if (widget.isNovaDespesaReceita == false &&
        widget.financeiroModel?.id != null &&
        widget.financeiroModel?.descricao != null) {
      descricaoText.text = widget.financeiroModel?.descricao ?? "";
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
        title: Text(
          "Adicionar Despesa/Receita",
          style: TextStyle(color: Colors.white),
        ),
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
                  controller: descricaoText,
                  icone: Icon(Icons.task_outlined),
                  labelText: "Descrição",
                  hinText: "Informe a descrição",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo obrigatório";
                    }
                    return null;
                  },
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
              if (widget.isNovaDespesaReceita == false &&
                  widget.financeiroModel?.id != null &&
                  widget.financeiroModel?.descricao != null) {
                await updateDespesaReceita();
              } else {
                await addDespesaReceita();
              }
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BottomNavigationBarApp(indexPage: 1);
                  },
                ),
                (route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    widget.isNovaDespesaReceita == true
                        ? 'Despesa/Receita Adicionada!'
                        : 'Despesa/Receita Editada!',
                  ),
                ),
              );
            }
          },
          label: Text(
            "Salvar Despesa/Receita",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          icon: Icon(Icons.check, color: Colors.white, size: 24.0),
        ),
      ),
    );
  }

  updateDespesaReceita() {
    financAux = FinanceiroModel(
      id: widget.financeiroModel?.id,
      descricao: descricaoText.text,
      quitada: widget.financeiroModel?.quitada,
      valor: widget.financeiroModel?.valor,
      data: widget.financeiroModel?.data,
      tipo: widget.financeiroModel?.tipo,
    );
    db.update(financAux);
  }

  addDespesaReceita() {
    financAux = FinanceiroModel(
      id: 1,
      descricao: descricaoText.text,
      quitada: 0,
      valor: "0.0",
      data: "212121",
      tipo: 0,
    );
    db.add(financAux);
  }
}
