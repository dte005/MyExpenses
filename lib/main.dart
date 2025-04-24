import 'package:flutter/material.dart';

import './home_page.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});
  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      // ThemeData fornece a possibilidade de definicao de cores tema
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple[300],
          foregroundColor: Colors.white, //Cores dos botoes
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          primary: Colors.purple[300],
          secondary: Colors.white,
          tertiary: Colors.blueGrey[400],
        ),
      ),
    );
  }
}
