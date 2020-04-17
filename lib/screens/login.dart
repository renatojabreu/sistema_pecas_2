import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_pecas_2/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:sistema_pecas_2/screens/novo_pedido2.dart';

import '../toasts.dart';

class LoginScreen extends StatelessWidget {
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  String varAut = null;

  Future<void> _login() async {
    Map<String, dynamic> newLogin = Map(); //Adiciona o usuário
    newLogin["usuario"] = _usuarioController.text.trimLeft();
    newLogin["senha"] = _senhaController.text.trimLeft();

    Map<String, String> headers = new Map<String, String>();
    headers["Content-type"] = "application/json";
    headers["Accept"] = "application/json";

    int timeout = 20;
    // try {
    http.Response response = await http
        // .post('http://webhook.site/86f3f241-2ab6-4b3f-a4a2-8fe5edd6ad55',
        .post('https://sistema.hutransportes.com.br/api/login.php',
            headers: headers, body: jsonEncode(newLogin), encoding: utf8)
        .timeout(Duration(seconds: timeout));

    print(newLogin);
    print(response.statusCode);
    print(response.body);
    //Map responseDecode = jsonDecode(response.body);
    //print(responseDecode);
    // if (response.statusCode == 200) {
    //   print("foi");
    //   if (response.body == "ok") {
    //   } else {
    //     print("n foi");
    //   }
    // } else {
    //   //Pode ter enviado e não recebido o código 200 ou ok
    // }
    // }
    // on TimeoutException catch (e) {
    //   print('Timeout Error: $e');
    //   ShowToast(context);
    // } on SocketException catch (e) {
    //   print('Socket Error: $e');
    //   ShowToast(context);
    // } on Error catch (e) {
    //   print('General Error: $e');
    //   ShowToast(context);
    // }
  }

  Future<void> _login2() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    String url = 'https://sistema.hutransportes.com.br/api/login.php';

    Map map = {"usuario": "", "senha": ""};
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();

    print(reply);
  }

  // void getHttp() async {
  //   try {
  //     Response response =
  //         await Dio().get("https://sistema.hutransportes.com.br/api/login.php");
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> _login3() async {
  //   // Dio dio = new Dio();
  //   // if (Platform.isAndroid) {
  //   //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //   //       (client) {
  //   //     client.badCertificateCallback =
  //   //         (X509Certificate cert, String host, int port) => true;
  //   //     return client;
  //   //   };
  //   // }

  //   Response response;
  //   // await Dio().get("https://sistema.hutransportes.com.br/api/login.php");
  //   // Response response;

  //   await Dio().post("/test", data: {"user": "renato", "password": "123456"});
  //   print(response.data.toString());
  // }

  Future<void> _login4() async {
    Response response;
    Dio dio = new Dio();
    String url = 'https://sistema.hutransportes.com.br/api/login.php';

    response = await dio.post(url, data: {
      "usuario": _usuarioController.text,
      "senha": _senhaController.text
    });

    print(response.data.toString());

    final decoded = json.decode(response.data);
    print(decoded);
    var decodedList = decoded.values.toList();
    varAut = decodedList[0];
    print(varAut);
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = 42;
    prefs.setInt(key, value);
    print('saved $value');
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Solicitação de Peças"),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Opacity(
              opacity: 0.85,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child:
                          Image.asset('assets/images/logo_hungaro_app.png'))),
            ),
            TextFormField(
              controller: _usuarioController,
              decoration: InputDecoration(hintText: "Email"),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text.isEmpty) return "usuário inválido";
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _senhaController,
              decoration: InputDecoration(hintText: "Senha"),
              obscureText: true,
              validator: (text) {
                if (text.isEmpty || text.length < 6) return "senha inválida";
              },
            ),
            SizedBox(
              height: 12.0,
            ),
            SizedBox(
                height: 48.0,
                child: RaisedButton(
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      Response response;
                      Dio dio = new Dio();
                      String url =
                          'https://sistema.hutransportes.com.br/api/login.php';

                      response = await dio.post(url, data: {
                        "usuario": _usuarioController.text
                            .replaceAll(new RegExp(r"\s+\b|\b\s"), ""),
                        "senha": _senhaController.text
                      });

                      print(response.data.toString());

                      final decoded = json.decode(response.data);
                      print(decoded);
                      var decodedList = decoded.values.toList();
                      varAut = decodedList[0];
                      if (varAut == "erro") {
                        ShowToastLoginError(context);
                        print("erro de autenticação");
                      } else {
                        // print(decodedList[4]);
                        var usuarioLogado = decodedList[4];
                        print("varaut é :" + varAut);

                        //começa
                        final prefs = await SharedPreferences.getInstance();
                        final key = 'usuario';
                        final value = usuarioLogado;
                        prefs.setString(key, value);
                        print('saved $value');
                        //fim

                        if (varAut == "ok") {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Pedidos()));
                        }
                      }
                    }
                    //_login4();

                    //_login();
                    // if ((_formKey.currentState.validate()) &&
                    //     (varAut == "ok")) {
                    //   Navigator.of(context).pushReplacement(
                    //       MaterialPageRoute(builder: (context) => Pedidos()));
                    // }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
