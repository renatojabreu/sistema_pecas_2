import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_pecas_2/objects/pedidos_itens.dart';

import '../toasts.dart';

List dataHolder;

class PedidoListView extends StatelessWidget {
  // BuildContext get context => null;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pedido>>(
      future: _fetchPedido(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Pedido> data = snapshot.data;
          return _pedidoListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.all(5),
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation(Colors.green),
            ),
          ),
        );
      },
    );
  }

  // @override
  // Widget build1(BuildContext context) {
  //   return FutureBuilder<List<Itens>>(
  //     future: _fetchItens(String),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         List<Itens> data = snapshot.data;
  //         return _itensListView(data);
  //       } else if (snapshot.hasError) {
  //         return Text("${snapshot.error}");
  //       }
  //       return CircularProgressIndicator();
  //     },
  //   );
  // }

  Future<List<Pedido>> _fetchPedido(BuildContext context) async {
    //Classe para carregar os pedidos da api
    //
    final prefs = await SharedPreferences.getInstance(); //pega o usuário logado
    final key = 'usuario';
    final value = prefs.getString(key);
    print('saved tester $value');
    String usu = value; //fim

    //Carrega os itens da api
    Response response = await Dio().post(
        "https://sistema.hutransportes.com.br/api/historico_pedido.php",
        data: {"usuario": usu});

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.data);
      print(response.data);
      return jsonResponse.map((job) => new Pedido.fromJson(job)).toList();
    } else {
      throw Exception('Falha ao carregar histórico');
    }
  }

  // List<dynamic> testList = [];
  // List<Itens> _pedList = new List<Itens>();
  // sendListtoOtherPage(List<dynamic> jsonResponse1) {
  //   for (Itens _pedItems in jsonResponse1) {
  //     _pedList.add(_pedItems);
  //   }
  //   ;
  // }

  List<Itens> pedList = [];
  Future<List<Itens>> _fetchItens(codPed) async {
    final prefs = await SharedPreferences.getInstance(); //pega o usuário logado
    final key = 'usuario';
    final value = prefs.getString(key);
    print('saved tester $value');
    String usu = value; //fim
    //Classe para carregar os itens da api
    //
    //Carrega os itens da api
    Response response = await Dio().post(
        "https://sistema.hutransportes.com.br/api/historico_itens_pedido.php",
        data: {"usuario": usu, "cod_pedido": codPed});

    if (response.statusCode == 200) {
      List jsonResponse1 = json.decode(response.data);
      print(response.data);
      // final decoded = json.decode(response.data);
      print("Below this is jsonresponse1");
      print(jsonResponse1);
      // testList.add(jsonResponse1);
      dataHolder = jsonResponse1;

      // print(jsonResponse1[0]['descricao']);
      // print(jsonResponse1[1]['descricao']);
      // List ResponseOK;
      //  var concatenate = StringBuffer();
      for (var i = 0; i < jsonResponse1.length; i++) {
        // print("BBB");
        // print(jsonResponse1[i]['descricao']);
        // List itens = jsonResponse1[i]['descricao'];
        // print(itens);
        // ResponseOK[i] = jsonResponse1[i]['descricao'];

        // concatenate.write("\n" + jsonResponse1[i]['descricao'] + "\n");
        //  print(concatenate);
      }

      // BotToast.showText(
      //     onlyOne: true,
      //     clickClose: true,
      //     crossPage: true,
      //     textStyle: TextStyle(fontSize: 12, color: Colors.white),
      //     duration: Duration(seconds: 3),
      //     text: concatenate.toString(),
      //     contentColor: Colors.green,
      //     contentPadding: EdgeInsets.all(25.0),
      //     align: Alignment(0, 0),
      //     backgroundColor: Colors.black38);

      //print(ResponseOK.toString());

      // BotToast.showText(
      //     text: "teste",
      //     contentColor: Colors.green,
      //     contentPadding: EdgeInsets.all(25.0),
      //     align: Alignment(0, 0.4),
      //     backgroundColor: Colors.black38);

      // print(decoded);
      // var decodedList = decoded.values.toList();
      // varAut = decodedList[0];
      // print(decodedList[4]);
      // var usuarioLogado = decodedList[4];
      // print(varAut);

      return jsonResponse1.map((job) => new Itens.fromJson(job)).toList();
    } else {
      throw Exception('Falha ao carregar histórico');
    }
  }

  // ListView _itensListView(data) {
  //   //itens do pedido
  //   return ListView.builder(
  //       itemCount: data.length,
  //       itemBuilder: (context, index) {
  //         return _tile(data[index].descricao, data[index].statusDescricao,
  //             Icons.settings, context, index);
  //       });
  // }

  ListView _pedidoListView(data) {
    for (int i = 0; i < data.length - 1; i++) {
      // listOfPedLists.add(pedList);
    }
    // print(listOfPedLists);
    //print("list of pedlists acima");
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(
              data[index].codPedido + " - " + data[index].hrCadastro,
              "Status: " +
                  data[index].statusDescricao +
                  "\nBox: " +
                  data[index].box +
                  " " +
                  data[index].tipoVeiculo +
                  " " +
                  data[index].placa,
              Icons.arrow_right,
              context,
              index);
        });
  }

  // List<Itens> listFromFuture = [];
  // List<List<Itens>> listOfPedLists = [];

  ListTile _tile(String title, String subtitle, IconData icon,
      BuildContext context, int counter) {
    // if (title){}
    return ListTile(
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(subtitle),
      leading: Icon(
        icon,
        color: Colors.green[500],
      ),
      onTap: () {
        _fetchItens(title).then((List<Itens> list) {
          showDialog(
            context: context,
            barrierDismissible: true,
            child: Dialog(
              backgroundColor: Colors.green[50],
              // child: Center(
              child: SizedBox(
                height: 450.0,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: ListView.builder(
                        //shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            dense: true,
                            title: Text(list[index].descricao),
                            isThreeLine: false,
                          );
                        },
                        itemCount: list.length,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: FlatButton(
                            color: Colors.green,
                            child: Text(
                              "Voltar",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop(true);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ),
          );
        });
        // populateUpperList(_fetchPed(title));
        // for (int i = 0; i < dataHolder.length; i++) {
        //   listOfPedLists[counter].add(Ped.fromJson(dataHolder[i]));
        // }
      },
    );
  }
}
