import 'package:flutter/material.dart';
import 'package:sistema_pecas_2/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
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
              decoration: InputDecoration(hintText: "Email"),
              keyboardType: TextInputType.emailAddress,
              // validator: (text) {
              //   if (text.isEmpty || !text.contains("@"))
              //     return "e-mail inválido";
              // },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Senha"),
              obscureText: true,
              // validator: (text) {
              //   if (text.isEmpty || text.length < 6) return "senha inválida";
              // },
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
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Pedidos()));
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
