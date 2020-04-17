import 'package:flutter/material.dart';
import 'package:sistema_pecas_2/screens/historico.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:sistema_pecas_2/screens/novo_pedido2.dart';

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
          resizeToAvoidBottomPadding: true,
          body: TabBarView(children: [
            Pedidos2(),
            Historico(),
          ]),
        ),
      ),
    );
  }
}
