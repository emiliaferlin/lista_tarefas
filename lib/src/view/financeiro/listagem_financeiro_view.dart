import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/cards/card_financeiro.dart';
import 'package:lista_tarefa/src/database/financeiro/financeiroDao.dart';
import 'package:lista_tarefa/src/model/financeiro/financeiro_model.dart';
import 'package:lista_tarefa/src/view/financeiro/formulario_financeiro_view.dart';

class ListagemFinanceiroView extends StatefulWidget {
  const ListagemFinanceiroView({super.key});

  @override
  State<ListagemFinanceiroView> createState() => _ListagemFinanceiroViewState();
}

class _ListagemFinanceiroViewState extends State<ListagemFinanceiroView> {
  Financeirodao db = Financeirodao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Financeiro", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<FinanceiroModel>>(
                initialData: [],
                future: db.findAll(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.data != null) {
                        List<FinanceiroModel>? listaFinanc = snapshot.data;
                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          itemCount: listaFinanc?.length,
                          itemBuilder: (context, index) {
                            return CardFinanceiro(
                              dadosFinanceiro: listaFinanc?[index],
                              db: db,
                              onChangedCheckBox: (value) {
                                updateQuitada(listaFinanc?[index], value);
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
                return FormularioFinanceiroView(isNovaDespesaReceita: true);
              },
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white, size: 28.0),
      ),
    );
  }

  updateQuitada(FinanceiroModel? financ, bool? value) {
    FinanceiroModel financeiro = FinanceiroModel(
      id: financ?.id,
      descricao: financ?.descricao,
      valor: financ?.valor,
      data: financ?.data,
      tipo: financ?.tipo,
      quitada: value == true ? 1 : 0,
    );
    db.update(financeiro);
    setState(() {});
    if (value == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            financ?.tipo == 0 ? "Despesa Quitada!" : "Receita Recebida!",
          ),
        ),
      );
    }
  }
}
