import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../toasts.dart';

class Hist {
  //Classe para criar os itens
  final String codPedido;
  final String status;
  final String statusDescricao;
  final String usuario;
  final String placa;
  final String box;
  final String tipoVeiculo;
  final String dtCadastro;
  final String hrCadastro;

  Hist(
      {this.codPedido,
      this.status,
      this.statusDescricao,
      this.usuario,
      this.placa,
      this.box,
      this.tipoVeiculo,
      this.dtCadastro,
      this.hrCadastro});

  factory Hist.fromJson(Map<String, dynamic> json) {
    return Hist(
        codPedido: json['cod_pedido'],
        status: json['status'],
        statusDescricao: json['status_descricao'],
        usuario: json['usuario'],
        placa: json['placa'],
        box: json['box'],
        tipoVeiculo: json['tipo_veiculo'],
        dtCadastro: json['dt_cadastro'],
        hrCadastro: json['hr_cadastro']);
  }
}

List dataHolder;

class Ped {
  //Classe para criar os itens
  final String codPedido;
  final String status;
  final String statusDescricao;
  final String descricao;

  Ped({this.codPedido, this.status, this.statusDescricao, this.descricao});

  factory Ped.fromJson(Map<String, dynamic> json) {
    return Ped(
        codPedido: json['cod_pedido'],
        status: json['status'],
        statusDescricao: json['status_descricao'],
        descricao: json['descricao']);
  }
}

class HistListView extends StatelessWidget {
  // BuildContext get context => null;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hist>>(
      future: _fetchHist(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Hist> data = snapshot.data;
          return _histListView(data);
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
  Widget build1(BuildContext context) {
    return FutureBuilder<List<Ped>>(
      future: _fetchPed(String),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Ped> data = snapshot.data;
          return _pedListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Hist>> _fetchHist(BuildContext context) async {
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
      return jsonResponse.map((job) => new Hist.fromJson(job)).toList();
    } else {
      throw Exception('Falha ao carregar histórico');
    }
  }

  List<dynamic> testList = [];
  List<Ped> _pedList = new List<Ped>();
  sendListtoOtherPage(List<dynamic> jsonResponse1) {
    for (Ped _pedItems in jsonResponse1) {
      _pedList.add(_pedItems);
    }
    ;
  }

  List<Ped> pedList = [];
  Future<List<Ped>> _fetchPed(codPed) async {
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
      testList.add(jsonResponse1);
      dataHolder = jsonResponse1;

      // print(jsonResponse1[0]['descricao']);
      // print(jsonResponse1[1]['descricao']);
      // List ResponseOK;
      var concatenate = StringBuffer();
      for (var i = 0; i < jsonResponse1.length; i++) {
        // print("BBB");
        print(jsonResponse1[i]['descricao']);
        // List itens = jsonResponse1[i]['descricao'];
        // print(itens);
        // ResponseOK[i] = jsonResponse1[i]['descricao'];

        concatenate.write("\n" + jsonResponse1[i]['descricao'] + "\n");
        print(concatenate);
      }

      BotToast.showText(
          onlyOne: true,
          clickClose: true,
          crossPage: true,
          textStyle: TextStyle(fontSize: 12, color: Colors.white),
          duration: Duration(seconds: 3),
          text: concatenate.toString(),
          contentColor: Colors.green,
          contentPadding: EdgeInsets.all(25.0),
          align: Alignment(0, 0),
          backgroundColor: Colors.black38);

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

      return jsonResponse1.map((job) => new Ped.fromJson(job)).toList();
    } else {
      throw Exception('Falha ao carregar histórico');
    }
  }

  ListView _pedListView(data) {
    //itens do pedido
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].descricao, data[index].statusDescricao,
              Icons.settings, context, index);
        });
  }

  ListView _histListView(data) {
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
              Icons.settings,
              context,
              index);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon,
          BuildContext context, int counter) =>
      ListTile(
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
          _fetchPed(title);
          for (int i = 0; i < dataHolder.length; i++) {
            pedList.add(Ped.fromJson(dataHolder[0]));
          }
          // showDialog(
          //     context: context,
          //     barrierDismissible: true,
          //     child: AlertDialog(
          //       title: Text(pedList[counter].descricao),
          //       content: Text((pedList[counter].descricao)),
          //       actions: <Widget>[
          //         // FlatButton(
          //         //   child: Text("Okay"),
          //         //   onPressed: () {
          //         //     // Navigator.of(context).pop();
          //         //   },
          //         // )
          //       ],
          //     ));
        },
      );
}
