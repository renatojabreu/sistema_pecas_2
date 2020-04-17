import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

ShowToast(BuildContext context) {
  Vibration.vibrate(duration: 850);
  return BotToast.showText(
      text: 'ERRO \n \n Lista não enviada',
      contentColor: Colors.red,
      contentPadding: EdgeInsets.all(25.0),
      align: Alignment(0, 0.4),
      backgroundColor: Colors.black45);
}

ShowToast1(BuildContext context) {
  Vibration.vibrate(duration: 150);
  return BotToast.showText(
      text: 'Lista enviada com sucesso!',
      contentColor: Colors.green,
      contentPadding: EdgeInsets.all(25.0),
      align: Alignment(0, 0.4),
      backgroundColor: Colors.black38);
}

ShowToastEmpty(BuildContext context) {
  Vibration.vibrate(duration: 300);
  return BotToast.showText(
      text: 'ERRO \n \n Lista vazia',
      contentColor: Colors.red[300],
      contentPadding: EdgeInsets.all(25.0),
      align: Alignment(0, 0.3),
      backgroundColor: Colors.black45);
}

ShowToastBlank(BuildContext context) {
  Vibration.vibrate(duration: 300);
  return BotToast.showText(
      duration: Duration(seconds: 3),
      text: 'Lista não enviada, existem campos em branco',
      contentColor: Colors.red[300],
      contentPadding: EdgeInsets.all(25.0),
      align: Alignment(0, 0.2),
      backgroundColor: Colors.black45);
}

ShowToastLoginError(BuildContext context) {
  Vibration.vibrate(duration: 300);
  return BotToast.showText(
      text: 'ERRO \n \n Usuário ou senha incorretos',
      contentColor: Colors.red[300],
      contentPadding: EdgeInsets.all(25.0),
      align: Alignment(0, 0.2),
      backgroundColor: Colors.black45);
}
