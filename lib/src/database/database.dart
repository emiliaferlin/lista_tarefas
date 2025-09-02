import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  String tableSql =
      'CREATE TABLE tarefas ('
      ' id INTEGER PRIMARY KEY, '
      ' descricao TEXT, '
      ' obs TEXT, '
      ' status INTEGER)';

  String tableSql2 =
      'CREATE TABLE financeiro ('
      ' id INTEGER PRIMARY KEY, '
      ' descricao TEXT, '
      ' valor TEXT, '
      ' data TEXT, '
      ' quitada INTEGER, '
      ' tipo INTEGER)';

  String path = join(await getDatabasesPath(), 'dbtarefas.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(tableSql);
      db.execute(tableSql2);
    },
    version: 1,
  );
}
