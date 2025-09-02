import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/components/navigation_bar/navigation_bar.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';

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
      home: BottomNavigationBarApp(indexPage: 0),
    );
  }
}
