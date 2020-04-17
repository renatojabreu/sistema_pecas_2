import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sistema_pecas_2/screens/histlistview.dart';

class Historico extends StatefulWidget {
  @override
  _HistoricoState createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  // void getHistorico() async {
  //   try {
  //     Response response = await Dio().get(
  //         "https://sistema.hutransportes.com.br/api/historico_itens_pedido.php");
  //     print(response);
  //     final decoded = json.decode(response.data);
  //     print(decoded);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // getHistorico();
  }

  List _pautasList = [
    {
      "titulo": "Pedido 1",
      "pecas": "peça A, peça B",
      "resumo": "Resumo",
      "texto":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
    },
    {
      "titulo": "Pedido 2",
      "pecas": "Peça C",
      "resumo": "Resumo",
      "texto":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: TabBar(
                indicatorColor: Colors.amber,
                tabs: [
                  Tab(icon: Icon(Icons.playlist_add)),
                  Tab(icon: Icon(Icons.history))
                ],
              ),
              centerTitle: true,
              backgroundColor: Colors.green),
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      " HISTÓRICO DE PEDIDOS ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          backgroundColor: Colors.green),
                    ),
                  ),
                ],
              ),
              Expanded(
                  // padding: const EdgeInsets.all(8.0),
                  child: HistListView()
                  //
                  // ListView.builder(
                  //     itemCount: _pautasList.length,
                  //     itemBuilder: (context, index) {
                  //       return ListTile(
                  //         dense: true,
                  //         // key: Key(DateTime.now()
                  //         //     .millisecondsSinceEpoch
                  //         //     .toString()
                  //         //     ),
                  //         title: Text(
                  //           _pautasList[index]["titulo"],
                  //           style: TextStyle(fontSize: 16.0),
                  //         ),
                  //         // subtitle: Text(
                  //         //   _pautasList[index]["pecas"],
                  //         // ),
                  //         trailing: GestureDetector(
                  //           child: Icon(Icons.delete_forever,
                  //               color: Colors.redAccent),
                  //           onTap: () {},
                  //         ),
                  //       );
                  //     }),
                  )
            ],
          )),
    );
  }
}
