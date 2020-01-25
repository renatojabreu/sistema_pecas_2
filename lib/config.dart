import 'package:flutter/material.dart';
import 'package:sistema_pecas_2/main.dart';

class Config extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text("Configurações"), backgroundColor: Colors.green),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[Text("O IP atual é:")],
            ),
            TextField(),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Voltar'),
                ),
              ],
              //alignment: Alignment.bottomRight,
            ),
          ],
        ));
  }
}
