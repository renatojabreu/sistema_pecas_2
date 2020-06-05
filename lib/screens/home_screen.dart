import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_pecas_2/screens/historico.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:sistema_pecas_2/screens/novo_pedido2.dart';

import 'login.dart';

class Pedidos extends StatefulWidget {
  @override
  _PedidosState createState() => _PedidosState();
}

class _PedidosState extends State<Pedidos> with TickerProviderStateMixin {
  TabController _tabController; //Abas não estão sendo usadas

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
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
          resizeToAvoidBottomPadding: true,
          body: TabBarView(children: [
            Pedidos2(),
            Historico(),
          ]),
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
                    leading: Icon(Icons.remove_circle),
                    title: Text('SAIR'),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      setState(() {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      });
                    },
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.network_wifi),
                  //   title: Text('IP atual: ' + mostraIpAtual(ipServidor)),
                  //   onTap: () {
                  //     // This line code will close drawer programatically....
                  //   },
                  // ),
                  // ListTile(
                  //   leading: Icon(Icons.settings_applications),
                  //   title: Text("Alterar IP"),
                  //   onTap: () {},
                  //   onLongPress: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return AlertDialog(
                  //               title: new Text("INSIRA O NOVO IP E PORTA"),
                  //               content: TextField(
                  //                 controller: _ipController,
                  //                 decoration: InputDecoration(
                  //                     hintText: "000.000.000.00:0000"),
                  //               ),
                  //               actions: <Widget>[
                  //                 FlatButton(
                  //                   child: new Text("Fechar"),
                  //                   onPressed: () {
                  //                     Navigator.of(context).pop();
                  //                   },
                  //                 ),
                  //                 FlatButton(
                  //                   child: new Text("Salvar"),
                  //                   onPressed: () {
                  //                     setState(() {
                  //                       ipServidor = (_ipController.text);
                  //                       Navigator.of(context).pop();
                  //                     });
                  //                   },
                  //                 ),
                  //               ]);
                  //         });
                  //   },
                  // ),
                  Divider(height: 2.0),
                ],
              )),
        ),
      ),
    );
  }
}
