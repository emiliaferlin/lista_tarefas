import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_tarefa/src/components/fields/text_form_field.dart';
import 'package:lista_tarefa/src/components/navigation_bar/navigation_bar.dart';
import 'package:lista_tarefa/src/database/financeiro/financeiroDao.dart';
import 'package:lista_tarefa/src/model/financeiro/financeiro_model.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';
import 'package:brasil_fields/brasil_fields.dart';

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
  TextEditingController valorText = TextEditingController();
  TextEditingController dataText = TextEditingController();
  DateTime? dataInicial;
  Financeirodao db = Financeirodao();
  FinanceiroModel financAux = FinanceiroModel();
  int? despesaReceita;

  @override
  void initState() {
    if (widget.isNovaDespesaReceita == false &&
        widget.financeiroModel?.id != null &&
        widget.financeiroModel?.descricao != null) {
      descricaoText.text = widget.financeiroModel?.descricao ?? "";
      valorText.text = widget.financeiroModel?.valor ?? "";
      dataText.text = widget.financeiroModel?.data ?? "";
      despesaReceita = widget.financeiroModel?.tipo;
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
          widget.financeiroModel?.tipo != null
              ? "Editar ${widget.financeiroModel?.tipo == 0 ? "Despesa" : "Receita"}"
              : "Adicionar Receita/Despesa",
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
                TextFormFieldComponente(
                  controller: valorText,
                  icone: Icon(Icons.attach_money_outlined),
                  labelText: "Valor",
                  hinText: "Informe o valor",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo obrigatório";
                    }
                    return null;
                  },
                  textInputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    RealInputFormatter(moeda: true),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<int>(
                        title: const Text('Despesa'),
                        value: 0,
                        activeColor: primaryColor,
                        groupValue: despesaReceita,
                        onChanged: (int? value) {
                          setState(() {
                            despesaReceita = value;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<int>(
                        title: const Text('Receita'),
                        value: 1,
                        groupValue: despesaReceita,
                        activeColor: primaryColor,
                        onChanged: (int? value) {
                          setState(() {
                            despesaReceita = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  child: TextFormFieldComponente(
                    controller: dataText,
                    icone: Icon(Icons.calendar_month_outlined),
                    labelText: "Data",
                    hinText: "Informe a data",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Campo obrigatório";
                      }
                      return null;
                    },
                    enable: false,
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: dataInicial ?? DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2030),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        dataInicial = pickedDate;
                        dataText.text = UtilData.obterDataDDMMAAAA(pickedDate);
                      });
                    }
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
              if (despesaReceita == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Selecione se é despesa ou receita")),
                );
              } else {
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
                          ? '${despesaReceita == 0 ? "Despesa" : "Receita"} Adicionada!'
                          : '${despesaReceita == 0 ? "Despesa" : "Receita"} Editada!',
                    ),
                  ),
                );
              }
            }
          },
          label: Text(
            widget.financeiroModel?.tipo != null
                ? "Salvar ${widget.financeiroModel?.tipo == 0 ? "Despesa" : "Receita"}"
                : "Salvar Receita/Despesa",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          icon: Icon(Icons.check, color: Colors.white, size: 24.0),
        ),
      ),
    );
  }

  updateDespesaReceita() {
    db.update(
      FinanceiroModel(
        id: widget.financeiroModel?.id,
        descricao: descricaoText.text,
        quitada: widget.financeiroModel?.quitada,
        valor: valorText.text,
        data: dataText.text,
        tipo: despesaReceita,
      ),
    );
  }

  addDespesaReceita() {
    db.add(
      FinanceiroModel(
        descricao: descricaoText.text,
        quitada: 0,
        valor: valorText.text,
        data: dataText.text,
        tipo: despesaReceita,
      ),
    );
  }
}
