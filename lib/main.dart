import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistema_pecas_2/screens/novo_pedido.dart';
import 'package:sistema_pecas_2/screens/splashscreen.dart';
import 'Screens/login.dart';
import 'screens/home_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

void main() => runApp(new MyApp());

class _MyAppState extends State<MyApp> {
  // Future<void> verificaLogin() async {
  //   print("running ok"); //just to test if the function runs
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'usuario';
  //   final value = prefs.getString(key);
  //   print('saved tester $value');
  //   String usu = value;

  //   if (usu.isEmpty) {
  //     BuildContext context;
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               LoginScreen()), //sends to loginscreen if not logged
  //     );
  //   }
  //   if (usu.isNotEmpty) {
  //     BuildContext context;
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (context) =>
  //             Pedidos())); //sends to main (not main.dart) app page
  //   }
  // }

  @override
  void initState() {
    super.initState();
    //  WidgetsBinding.instance.addPostFrameCallback((_) => verificaLogin());
  }

  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
        title: "Solicitação de Peças",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home:
            SplashScreen(), //i'm calling the loginscreen, it ignores the function on the top
      ),
    );
  }
}

//MODO ORIGINAL STATELESS

// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sistema_pecas_2/screens/novo_pedido.dart';
// import 'Screens/login.dart';
// import 'screens/home_screen.dart';

// void main() => runApp(new MyApp());

// Future<void> verificaLogin() async {
//   print("rodou esta porra");
//   final prefs = await SharedPreferences.getInstance();
//   final key = 'usuario';
//   final value = prefs.getString(key);
//   print('saved tester $value');
//   String usu = value;

//   if (usu.isEmpty) {
//     BuildContext context;
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => LoginScreen()),
//     );
//   }
//   if (usu.isNotEmpty) {
//     BuildContext context;
//     Navigator.of(context)
//         .pushReplacement(MaterialPageRoute(builder: (context) => Pedidos()));
//   }
// }

// class MyApp extends StatelessWidget {
//   // void initState() {
//   //   //  super.initState();
//   //   WidgetsBinding.instance.addPostFrameCallback((_) => verificaLogin());
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return BotToastInit(
//       child: MaterialApp(
//         navigatorObservers: [BotToastNavigatorObserver()],
//         title: "Solicitação de Peças",
//         theme: ThemeData(
//           primarySwatch: Colors.green,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: LoginScreen(),
//       ),
//     );
//   }
// }
