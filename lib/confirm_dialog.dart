import 'package:flutter/material.dart';

enum ConfirmAction { CANCEL, ACCEPT }

Future<ConfirmAction> ConfirmDialog(
    BuildContext context, String title, String content) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap on a button to close the dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text("Não"),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: Text("Sim"),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}
