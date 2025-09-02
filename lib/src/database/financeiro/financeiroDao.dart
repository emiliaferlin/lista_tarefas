import 'package:lista_tarefa/src/database/database.dart';
import 'package:lista_tarefa/src/model/financeiro/financeiro_model.dart';
import 'package:sqflite/sqflite.dart';

class Financeirodao {
  String _tableName = "financeiro";

  //converte o objeto para map
  Map<String, dynamic> toMap(FinanceiroModel despesaReceita) {
    final Map<String, dynamic> financeiroMap = Map();
    financeiroMap['descricao'] = despesaReceita.descricao;
    financeiroMap['valor'] = despesaReceita.valor;
    financeiroMap['data'] = despesaReceita.data;
    financeiroMap['tipo'] = despesaReceita.tipo;
    financeiroMap['quitada'] = despesaReceita.quitada;

    return financeiroMap;
  }

  //converte o map para uma lista
  List<FinanceiroModel> toList(List<Map<String, dynamic>> result) {
    final List<FinanceiroModel> despesasReceitas = [];
    for (Map<String, dynamic> row in result) {
      FinanceiroModel financeiro = FinanceiroModel(
        id: row['id'],
        descricao: row['descricao'],
        quitada: row['quitada'],
        data: row['data'],
        tipo: row['tipo'],
        valor: row['valor'],
      );
      despesasReceitas.add(financeiro);
    }

    return despesasReceitas;
  }

  Future<int> add(FinanceiroModel despesaReceita) async {
    Database db = await getDatabase();
    Map<String, dynamic> financeiroMap = toMap(despesaReceita);
    return db.insert(_tableName, financeiroMap);
  }

  Future<int> update(FinanceiroModel despesaReceita) async {
    Database db = await getDatabase();
    Map<String, dynamic> financeiroMap = toMap(despesaReceita);
    return db.update(
      _tableName,
      financeiroMap,
      where: 'id = ?',
      whereArgs: [despesaReceita.id],
    );
  }

  Future<int> delete(int identificador) async {
    Database db = await getDatabase();
    return db.delete(_tableName, where: 'id = ?', whereArgs: [identificador]);
  }

  Future<List<FinanceiroModel>> findAll() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> result = await db.query(_tableName);
    List<FinanceiroModel> despesasReceitas = toList(result);
    return despesasReceitas;
  }
}
