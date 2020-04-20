import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_pecas_2/screens/home_screen.dart';
import 'package:sistema_pecas_2/screens/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String loginData = "";

  SharedPreferences sharedPreferences;
  void initState() {
    super.initState();
    readFromStorage();
  }

  void readFromStorage() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final key = 'usuario';
    loginData = sharedPreferences.getString(key);
    if ((sharedPreferences.containsKey('usuario') == false) ||
        loginData == null ||
        loginData.isEmpty) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        });
      });
    } else {
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Pedidos()));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(Colors.green),
          ),
        ],
      )),
    );
  }
}
