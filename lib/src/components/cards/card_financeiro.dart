import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/modais/modal_acao_receita_despesa.dart';
import 'package:lista_tarefa/src/database/financeiro/financeiroDao.dart';
import 'package:lista_tarefa/src/model/financeiro/financeiro_model.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';

class CardFinanceiro extends StatelessWidget {
  final FinanceiroModel? dadosFinanceiro;
  final Financeirodao? db;
  final Function(bool?)? onChangedCheckBox;
  const CardFinanceiro({
    super.key,
    this.dadosFinanceiro,
    this.db,
    this.onChangedCheckBox,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Checkbox(
              value: dadosFinanceiro?.quitada == 0 ? false : true,
              activeColor: primaryColor,
              onChanged: onChangedCheckBox,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(dadosFinanceiro?.descricao ?? "")),
                      IconButton(
                        onPressed: () {
                          acaoDespesaReceitaModalBottomSheet(
                            context,
                            dadosFinanceiro ?? FinanceiroModel(),
                            db ?? Financeirodao(),
                          );
                        },
                        icon: Icon(Icons.edit_note_outlined, size: 42.0),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          dadosFinanceiro?.data ?? DateTime.now().toString(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          dadosFinanceiro?.valor ?? "0.0",
                          style: TextStyle(
                            color:
                                dadosFinanceiro?.tipo == 0
                                    ? Colors.red
                                    : Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
