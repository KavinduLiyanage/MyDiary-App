import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mydiary/HomePage.dart';
import 'package:mydiary/src/app.dart';
import 'HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primaryColor: Colors.orange),
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
