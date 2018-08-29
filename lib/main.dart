import 'package:flutter/material.dart';
import 'LoginPage.dart';
void main(){
  runApp(new MyApp ());
  }
  
  class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'My Flutter Practice',
      theme: ThemeData(
        primarySwatch: Colors.blue 
      ),
      home: new LoginPage(),
    );
  }
}