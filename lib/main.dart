import 'package:flutter/material.dart';
import 'package:tech_task/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade700),
          useMaterial3: true,
        ),
        home: const HomePage());
  }
}
