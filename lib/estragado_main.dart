// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sistema_pecas_2/screens/login.dart';
// import 'package:sistema_pecas_2/screens/novo_pedido.dart';
// import 'Screens/login.dart';
// import 'screens/home_screen.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     verificaLogin(context);
//     return Scaffold(
//       body: Center(
//         child: Icon(
//           Icons.beach_access,
//         ),
//       ),
//     );
//   }
// }

// Future verificaLogin(context) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final key = 'usuario';
//   final value = prefs.getString(key);
//   print('saved tester $value');
//   String usu = value;
//   if (usu == null) {
//     /// If it's the first time, there is no shared preference registered
//     Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => LoginScreen()));
//   }
// }
//     print("rodou esta porra");
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'usuario';
//     final value = prefs.getString(key);
//     print('saved tester $value');
//     String usu = value;

//     if (usu.isEmpty || usu == null) {
//       BuildContext context;
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     } else if (usu.isNotEmpty) {
//       BuildContext context;
//       Navigator.of(context)
//           .pushReplacement(MaterialPageRoute(builder: (context) => Pedidos()));
//     }
//   }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// void main() => runApp(new MyApp());

// class _MyAppState extends State<MyApp> {
//   Future<void> verificaLogin() async {
//     print("rodou esta porra");
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'usuario';
//     final value = prefs.getString(key);
//     print('saved tester $value');
//     String usu = value;

//     if (usu.isEmpty || usu == null) {
//       BuildContext context;
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//       );
//     } else if (usu.isNotEmpty) {
//       BuildContext context;
//       Navigator.of(context)
//           .pushReplacement(MaterialPageRoute(builder: (context) => Pedidos()));
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => verificaLogin());
//   }

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
