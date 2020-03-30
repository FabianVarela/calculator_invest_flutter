import 'package:calculator_invest_flutter/ui/calculate_form.ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Invest Calculator App',
      home: CalculateFrom(),
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        accentColor: Colors.blue,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        errorColor: Colors.red
      ),
    ),
  );
}
