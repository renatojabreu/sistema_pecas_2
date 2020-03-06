import 'package:flutter/material.dart';

enum ConfirmAction { CANCEL, ACCEPT }

Future<ConfirmAction> ConfirmDialog(BuildContext context, String title) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap on a button to close the dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(title)),
        actions: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                color: Colors.grey,
                child: Text("Não"),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop(ConfirmAction.CANCEL);
                },
              ),
              Container(width: 10.0),
              FlatButton(
                color: Colors.green,
                child: Text("Sim"),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop(ConfirmAction.ACCEPT);
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
