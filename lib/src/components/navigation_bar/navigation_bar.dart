import 'package:flutter/material.dart';
import 'package:lista_tarefa/src/utils/constantes.dart';
import 'package:lista_tarefa/src/view/financeiro/listagem_financeiro_view.dart';
import 'package:lista_tarefa/src/view/tarefa/listagem_tarefas_view.dart';

class BottomNavigationBarApp extends StatefulWidget {
  final int indexPage;
  const BottomNavigationBarApp({super.key, required this.indexPage});

  @override
  State<BottomNavigationBarApp> createState() => _BottomNavigationBarAppState();
}

class _BottomNavigationBarAppState extends State<BottomNavigationBarApp> {
  int indexPage = 0;

  static const List<Widget> pagesOptions = <Widget>[
    ListagemTarefasView(),
    ListagemFinanceiroView(),
  ];

  void selectPage(int index) {
    setState(() {
      indexPage = index;
    });
  }

  @override
  void initState() {
    setState(() {
      indexPage = widget.indexPage;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: pagesOptions.elementAt(indexPage)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_rounded),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: 'Financeiro',
          ),
        ],
        currentIndex: indexPage,
        selectedItemColor: primaryColor,
        onTap: selectPage,
      ),
    );
  }
}
