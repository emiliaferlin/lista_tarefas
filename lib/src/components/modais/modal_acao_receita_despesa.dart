import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/modais/modal_confirmacao.dart';
import 'package:lista_tarefa/src/components/navigation_bar/navigation_bar.dart';
import 'package:lista_tarefa/src/database/financeiro/financeiroDao.dart';
import 'package:lista_tarefa/src/model/financeiro/financeiro_model.dart';
import 'package:lista_tarefa/src/view/financeiro/formulario_financeiro_view.dart';

void acaoDespesaReceitaModalBottomSheet(
  context,
  FinanceiroModel financeiro,
  Financeirodao db,
) {
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
                        return FormularioFinanceiroView(
                          financeiroModel: financeiro,
                          isNovaDespesaReceita: false,
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
                            'Deseja excluir essa ${financeiro.tipo == 0 ? "despesa" : "receita"} ${financeiro.descricao}?',
                        body:
                            'Após a exclusão, essa ${financeiro.tipo == 0 ? "despesa" : "receita"} não será mais exibida para você. ',
                        principal: "Excluir",
                      );
                    },
                  ).then((value) {
                    if (value == true) {
                      db.delete(financeiro.id ?? 0);
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
                            '${financeiro.tipo == 0 ? "Despesa" : "Receita"} Excluída!',
                          ),
                        ),
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
