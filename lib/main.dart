import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// Fichier généré automatiquement par "flutterfire configure"
import 'firebase_options.dart';

// Votre page d'accueil
import 'package:appli_histoire_aventure/pages/welcomescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
