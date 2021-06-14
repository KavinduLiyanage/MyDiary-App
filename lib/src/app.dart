import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mydiary/HomePage.dart';
import 'package:mydiary/src/providers/entry_provider.dart';
import 'package:mydiary/src/screens/entry_list.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EntryProvider(),
      child: MaterialApp(
        home: HomePage(),
        theme: ThemeData(primaryColor: Colors.orange),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}