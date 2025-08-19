import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';
import 'package:lista_tarefa/src/view/lista_tarefas_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: primaryColor),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
      ),
      home: const ListaTarefasView(),
    );
  }
}
