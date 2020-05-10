import 'package:calculator_invest_flutter/ui/calculate_form.ui.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Invest Calculator App',
      home: CalculateFrom(),
      theme: ThemeData(
        fontFamily: 'NotoSansJP',
        primaryColor: Colors.blueGrey,
        accentColor: Colors.blue,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        errorColor: Colors.red,
      ),
    );
  }
}
