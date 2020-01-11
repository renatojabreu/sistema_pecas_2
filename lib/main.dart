import 'dart:convert';
//import 'dart:ffi';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

void main() {
  runApp(MaterialApp(
    home: Pedidos(),
    debugShowCheckedModeBanner: false,
  ));
}

class Pedidos extends StatefulWidget {
  @override
  _PedidosState createState() => _PedidosState();
}

final FocusNode _secondInputFocusNode = new FocusNode();
final FocusNode _placaInputFocusNode = new FocusNode();
final FocusNode _boxInputFocusNode = new FocusNode();

class _PedidosState extends State<Pedidos> with TickerProviderStateMixin {
  TabController _tabController;

  final _pecasController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _placaController = TextEditingController();
  final _boxController = TextEditingController();

  List _pecasList = [];
  List _usuariosList = [];
  List _dadosList = [];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  void _addPecas() {
    //disableTextFormField();
    if ((_pecasController.text.isEmpty) ||
        ((_pecasController.text.trimLeft() == ("")))) {
      print("Campo Vazio");
    } else {
      setState(() {
        Map<String, dynamic> newPeca = Map();
        newPeca["title"] = _pecasController.text.trimLeft();
        //newPeca["ok"] = false;
        _pecasController.text = "";
        _pecasList.add(newPeca);
        // _saveData();
        print(_pecasList);
      });
    }
  }

  // bool textFormFieldEnabled = true;
  // void enableTextFormField() {
  //   setState(() {
  //     textFormFieldEnabled = true;
  //   });
  // }

  // void disableTextFormField() {
  //   setState(() {
  //     textFormFieldEnabled = false;
  //   });
  // }

  void _enviar() {
    if ((_usuarioController.text.isEmpty) ||
        (_placaController.text.isEmpty) ||
        (_boxController.text.isEmpty)) {
      Toast.show(
        "\n  Preencha todos os campos  \n",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundRadius: 5.0,
      );
    } else if (_pecasList.length < 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: new Text("Lista vazia"),
                actions: <Widget>[
                  new FlatButton(
                      child: new Text("Fechar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]);
          });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Deseja enviar os itens?"),
            actions: <Widget>[
              new FlatButton(
                  child: new Text("Fechar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              new FlatButton(
                  child: new Text("Enviar"),
                  //     onPressed: () {
                  //       Map<String, String> headers = new Map<String, String>();
                  //       headers["Content-type"] = "application/json";
                  //       headers["Accept"] = "application/json";
                  //       var resp = http.post('http://172.16.14.109:5000/',
                  //           //'http://webhook.site/5aa630a9-78b9-45d1-b665-53adf33c1fe7',
                  //           body: jsonEncode(_pecasList),
                  //           headers: headers);
                  //       print(resp);
                  //       setState(() {
                  //         print(_pecasList);
                  //         //_pecasList.clear();
                  //         Navigator.of(context).pop();
                  //       });
                  //     })

                  onPressed: () async {
                    Map<String, dynamic> newDados = Map(); //Adiciona o usuário
                    newDados["usuario"] = _usuarioController.text.trimLeft();
                    // _dadosList.add(newDados);
                    newDados["placa"] = _placaController.text.trimLeft();
                    //_dadosList.add(newDados);
                    newDados["box"] = _boxController.text.trimLeft();
                    _dadosList.add(newDados);

                    // _saveData();
                    print(_pecasList + _dadosList);

                    Map<String, String> headers = new Map<String, String>();
                    headers["Content-type"] = "application/json";
                    headers["Accept"] = "application/json";
                    //String str = '{"take":55, "skip":"0"}';
                    final resp = await http.post(
                        'http://webhook.site/9794de73-a3f0-43d1-b97e-a6d4830731e2',
                        body: jsonEncode(_dadosList +
                            _pecasList), //+ jsonEncode(_pecasList),
                        headers: headers);
                    print(resp.statusCode);

                    _dadosList
                        .clear(); //Limpa a lista de usuários para impedir de Fenviar mais de um

                    if (resp.statusCode == 200) {
                      if (resp.body == "ok") {
                        setState(() {
                          print(_pecasList);
                          _pecasList.clear();
                          Navigator.of(context).pop();
                        });
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: new Text(
                                      "Erro: entre em contato com o suporte."),
                                  actions: <Widget>[
                                    new FlatButton(
                                        child: new Text("Fechar"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        }),
                                  ]);
                            });
                      }
                    } else {
                      print("erro de comunicação");
                      // Navigator.of(context).pop();
                      // showDialog(
                      //     context: context,
                      //     builder: (BuildContext context) {
                      //       return AlertDialog(
                      //           title: new Text("Erro de comunicação."),
                      //           actions: <Widget>[
                      //             new FlatButton(
                      //                 child: new Text("Fechar"),
                      //                 onPressed: () {
                      //                   Navigator.of(context).pop();
                      //                 }),
                      //           ]);
                      //     });
                    }
                  })
            ],
          );
        },
      );
    }
  }

  void _apagarTudo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("Deseja limpar a lista?"),
              actions: <Widget>[
                new FlatButton(
                    child: new Text("Fechar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                new FlatButton(
                    child: new Text("Limpar"),
                    onPressed: () {
                      setState(() {
                        _pecasList.clear();
                        Navigator.of(context).pop();
                      });
                    }),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Solicitação de Peças",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.green),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: TextFormField(
                    inputFormatters: [
                      new BlacklistingTextInputFormatter(new RegExp('[ ]'))
                    ],
                    controller: _usuarioController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context)
                        .requestFocus(_placaInputFocusNode),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: ("Usuário"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: TextFormField(
                    inputFormatters: [
                      new BlacklistingTextInputFormatter(new RegExp('[ ]'))
                    ],
                    focusNode: _placaInputFocusNode,
                    controller: _placaController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_boxInputFocusNode),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: ("Placa"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: TextFormField(
                    inputFormatters: [
                      new BlacklistingTextInputFormatter(new RegExp('[ ]'))
                    ],
                    controller: _boxController,
                    focusNode: _boxInputFocusNode,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context)
                        .requestFocus(_secondInputFocusNode),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: ("Box"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: TextFormField(
                    focusNode: _secondInputFocusNode,
                    //validator: _validaCampo,
                    controller: _pecasController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: _addPecas,
                    //enabled: textFormFieldEnabled,
                    //onTap: () => enableTextFormField(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                      hintText: ("Adicionar item"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15),
                ),
                Expanded(
                  flex: 2,
                  child: RaisedButton(
                    child: Icon(Icons.add, color: Colors.amber),
                    color: Colors.green,
                    onPressed: _addPecas,
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 02.0,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _pecasList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    title: Text(
                      _pecasList[index]["title"],
                      style: TextStyle(fontSize: 16.0),
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.redAccent,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title:
                                  new Text("Deseja remover o item da lista?"),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("Fechar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text("Excluir"),
                                  onPressed: () {
                                    _pecasList.removeAt(index);
                                    setState(() {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: (MainAxisAlignment.center),
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    color: Colors.green,
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "Enviar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: _enviar,
                  )),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                      color: Colors.redAccent,
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "Limpar",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        _apagarTudo();
                      }))
            ],
          )
        ],
      ),
    );
  }
}
