import 'package:flutter/material.dart';
import 'package:ingilizcedefterim/screens/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'İngilizce Defterim',
      theme: ThemeData(
        fontFamily: 'Alfa',
      
        //primarySwatch: Colors.white,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

