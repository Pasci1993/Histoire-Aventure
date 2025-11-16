import 'package:appli_histoire_aventure/pages/WelcomeScreen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MonAppli());
}

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(title: "Histoire & Aventure"),
    );
  }
}