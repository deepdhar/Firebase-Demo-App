import 'package:flutter/material.dart';
import 'mainscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
        theme: ThemeData.dark());
  }
}

//Container(
//alignment: Alignment.center,
//child: Text(
//'Log In',
//style: TextStyle(
//fontSize: 25.0,
//color: Colors.white,
//fontFamily: 'Rubik',
//),
//),
//), //Login
