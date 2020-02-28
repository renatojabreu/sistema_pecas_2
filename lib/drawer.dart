import 'package:flutter/material.dart';
import 'main.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();

  Drawer(
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


  }
}
