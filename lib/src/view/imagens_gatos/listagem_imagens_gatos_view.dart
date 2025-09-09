import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lista_tarefa/src/components/cards/card_gato.dart';
import 'package:lista_tarefa/src/model/imagens_gatos/imagens_gatos_model.dart';

class ListagemImagensGatosView extends StatefulWidget {
  const ListagemImagensGatosView({super.key});

  @override
  State<ListagemImagensGatosView> createState() =>
      _ListagemImagensGatosViewState();
}

class _ListagemImagensGatosViewState extends State<ListagemImagensGatosView> {
  List<ImagensGatosModel> dadosGatos = [];
  getImagemGato() async {
    final res = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/images/search'),
    );
    List<dynamic> dados = jsonDecode(res.body);
    dados.forEach((element) {
      dadosGatos.add(ImagensGatosModel.fromMap(element));
    });
    setState(() {});
  }

  getMaisImagensGatos() async {
    final res = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/images/search?limit=10'),
    );
    List<dynamic> dados = jsonDecode(res.body);
    dados.forEach((element) {
      dadosGatos.add(ImagensGatosModel.fromMap(element));
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getImagemGato();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Imagens Gatos", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dadosGatos.length,
                itemBuilder: (context, index) {
                  return CardGato(dadosGatos: dadosGatos[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await getMaisImagensGatos();
        },
        label: Text(
          "Carregar mais imagens",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    );
  }
}
