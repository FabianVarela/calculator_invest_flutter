import 'package:calculator_invest_flutter/view/calculate_form_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Invest Calculator App',
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme),
        primaryColor: Colors.blueGrey,
        accentColor: Colors.blue,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueAccent),
        errorColor: Colors.red,
      ),
      home: CalculateFromView(),
    );
  }
}
