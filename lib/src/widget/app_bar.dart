import 'package:flutter/material.dart';

class AppBarNew extends StatelessWidget {
  const AppBarNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('My Journal'),
      leading: Icon(
        Icons.menu,
      ),
    );
  }
}
