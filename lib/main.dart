import 'dart:convert';
//import 'dart:ffi';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_pecas_2/confirm_dialog.dart';
import 'package:toast/toast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

void main() {
  runApp(MaterialApp(
    home: Pedidos(),
    theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: IconThemeData(color: Colors.green)),
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
//String dropdownValue = "BOX";
String dropdownValue1 = "Tipo de Veículo"; //teste
//teste2
//teste3
var maskFormatter = new MaskTextInputFormatter(
    mask: '###-####', filter: {"#": RegExp(r'[0-9A-Z]')});

class _PedidosState extends State<Pedidos> with TickerProviderStateMixin {
  TabController _tabController;

  final _pecasController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _placaController = TextEditingController();
  final _boxController = TextEditingController();
  final _ipController = TextEditingController();

  List _pecasList = [];
  List _usuariosList = [];
  List _dadosList = [];

  //Endereço do servidor
  String ipServidor = ('webhook.site/86f3f241-2ab6-4b3f-a4a2-8fe5edd6ad55');
  // ('webhook.site/86f3f241-2ab6-4b3f-a4a2-8fe5edd6ad55'); //Webhook funcionando
  //('177.125.217.10:6598/'); //IP correto

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
      FocusScope.of(context).unfocus();
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

  Future<void> _enviar() async {
    if ((_usuarioController.text.isEmpty) ||
        (_placaController.text.isEmpty) ||
        (_boxController.text.isEmpty) ||
        (dropdownValue1 == "Tipo de Veículo")) {
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
      ConfirmAction action =
          await ConfirmDialog(context, "Deseja enviar os itens?", "");
      if (action == ConfirmAction.ACCEPT) {
        Map<String, dynamic> newDados = Map(); //Adiciona o usuário
        newDados["usuario"] = _usuarioController.text.trimLeft();
        // _dadosList.add(newDados);
        newDados["placa"] = _placaController.text.trimLeft();
        //_dadosList.add(newDados);
        newDados["box"] = _boxController.text.trimLeft();
        // _dadosList.add(newDados);
        newDados["tipo_veiculo"] = dropdownValue1;
        _dadosList.add(newDados);

        // _saveData();
        print(_pecasList + _dadosList);

        // Map<String, String> newPeca = Map<String, String>();
        // int i = 0;
        // int j = _pecasList.length;
        // for (i = 0; i == j; i++) {
        //   newPeca["title"] += _pecasList[i];
        // }

        // print(_pecasList);

        Map<String, String> headers = new Map<String, String>();
        headers["Content-type"] = "application/json";
        headers["Accept"] = "application/json";
        //String str = '{"take":55, "skip":"0"}';
        final resp = await http.post('http://' + ipServidor,
            body:
                jsonEncode(_dadosList + _pecasList), //+ jsonEncode(_pecasList),
            headers: headers);

        print(resp.statusCode);

        _dadosList
            .clear(); //Limpa a lista de usuários para impedir de Fenviar mais de um

        print(resp.body);
        if (resp.statusCode == 200) {
          if (resp.body == "ok") {
            setState(() {
              print(_pecasList);
              _pecasList.clear();
              _placaController.clear();
              _boxController.clear();
              dropdownValue1 = "Tipo de Veículo";
              //Navigator.of(context).pop();
            });
          } else {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: new Text("Erro: entre em contato com o suporte."),
                      actions: <Widget>[
                        new FlatButton(
                            child: new Text("Fechar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Navigator.of(context).pop();
                            }),
                      ]);
                });
          }
        } else {
          print("erro de comunicação");
          Navigator.of(context).pop();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: new Text("Erro de comunicação."),
                    actions: <Widget>[
                      new FlatButton(
                          child: new Text("Fechar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ]);
              });
        }
      }
    }
  }

  void _apagarTudo() {
    setState(() {
      _pecasList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      maskFormatter,
                      //WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9-]")),
                      //new BlacklistingTextInputFormatter(new RegExp('[ ]'))
                    ],
                    maxLength: 8,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: TextFormField(
                        focusNode: _boxInputFocusNode,
                        controller: _boxController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        maxLength: 8,
                        // onEditingComplete: () => FocusScope.of(context).requestFocus(_boxInputFocusNode),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                          hintText: ("BOX"),
                        ),
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.only(right: 100.0),
                // ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue1,
                        //focusNode: _boxInputFocusNode,
                        //icon: Icon(Icons.arrow_downward),
                        //iconSize: 34,
                        elevation: 16,
                        hint: Text("Tipo de Veículo"),
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        underline: Container(
                          height: 2,
                          color: Colors.grey[400],
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue1 = newValue;
                          });
                        },
                        items: <String>[
                          'Tipo de Veículo',
                          'Cavalo',
                          'Carreta1',
                          'Carreta2',
                          'Dolly'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                )
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
                    maxLength: 50,
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
                      onPressed: () async {
                        ConfirmAction action = await ConfirmDialog(
                            context, "Deseja remover todos os itens?", "");
                        if (action == ConfirmAction.ACCEPT) {
                          _apagarTudo();
                        }
                      }))
            ],
          )
        ],
      ),
      drawer: Drawer(
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.red,
                title: Text("Configurações"),
              ),
              ListTile(
                leading: Icon(Icons.network_wifi),
                title: Text('IP atual: ' + ipServidor),
                onTap: () {
                  // This line code will close drawer programatically....
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings_applications),
                title: Text("Alterar IP"),
                onTap: () {},
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: new Text("INSIRA O NOVO IP:"),
                            content: TextField(
                              controller: _ipController,
                              decoration: InputDecoration(hintText: "Novo IP"),
                            ),
                            actions: <Widget>[
                              new FlatButton(
                                  child: new Text("Salvar"),
                                  onPressed: () {},
                                  onLongPress: () {
                                    setState(() {
                                      ipServidor = (_ipController.text);
                                      Navigator.of(context).pop();
                                    });
                                  }),
                              new FlatButton(
                                  child: new Text("Fechar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ]);
                      });
                },
              ),
              Divider(
                height: 2.0,
              ),
            ],
          )),
    );
  }
}
