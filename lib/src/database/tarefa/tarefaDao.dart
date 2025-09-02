import 'package:lista_tarefa/src/database/database.dart';
import 'package:lista_tarefa/src/model/tarefa/tarefa_model.dart';
import 'package:sqflite/sqflite.dart';

class Tarefadao {
  String _tableName = "tarefas";

  //converte o objeto para map
  Map<String, dynamic> toMap(TarefasModel tarefa) {
    final Map<String, dynamic> tarefaMap = Map();
    tarefaMap['descricao'] = tarefa.descricao;
    tarefaMap['obs'] = tarefa.observacao;
    tarefaMap['status'] = tarefa.status;

    return tarefaMap;
  }

  //converte o map para uma lista
  List<TarefasModel> toList(List<Map<String, dynamic>> result) {
    final List<TarefasModel> tarefas = [];
    for (Map<String, dynamic> row in result) {
      TarefasModel tarefa = TarefasModel(
        id: row['id'],
        descricao: row['descricao'],
        observacao: row['obs'],
        status: row['status'],
      );
      tarefas.add(tarefa);
    }

    return tarefas;
  }

  Future<int> add(TarefasModel tarefa) async {
    Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    return db.insert(_tableName, tarefaMap);
  }

  Future<int> update(TarefasModel tarefa) async {
    Database db = await getDatabase();
    Map<String, dynamic> tarefaMap = toMap(tarefa);
    return db.update(
      _tableName,
      tarefaMap,
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  Future<int> delete(int identificador) async {
    Database db = await getDatabase();
    return db.delete(_tableName, where: 'id = ?', whereArgs: [identificador]);
  }

  Future<List<TarefasModel>> findAll() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> result = await db.query(_tableName);
    List<TarefasModel> tarefas = toList(result);
    return tarefas;
  }
}
