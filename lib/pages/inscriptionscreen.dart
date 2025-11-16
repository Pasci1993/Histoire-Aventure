import 'package:appli_histoire_aventure/pages/loginscreen.dart';
import 'package:appli_histoire_aventure/pages/menuscreen.dart';
import 'package:flutter/material.dart';

// Classe du widget pour la page d'inscription
class InscriptionScreen extends StatelessWidget {
  const InscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Taille de l'écran pour le dimensionnement proportionnel
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // L'AppBar est implicite et donne le titre "Inscription" en haut à gauche
      appBar: AppBar(
        title: const Text('Inscription', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0, // Pas d'ombre
      ),
      // Le corps entier est un Container violet
      body: Container(
        color: Colors.deepPurple, // Couleur de fond principale
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView( // Permet de faire défiler si le clavier apparaît
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Espace en haut
                SizedBox(height: screenHeight * 0.05),

                // Titre "Inscription"
                const Text(
                  'Inscription',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: screenHeight * 0.06),
                
                // --- Champ Pseudo ---
                const Text(
                  'Choisis ton pseudo',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                _buildWhiteTextField(),

                SizedBox(height: screenHeight * 0.04),

                // --- Champ Mot de passe ---
                const Text(
                  'Choisis ton mot de passe',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                _buildWhiteTextField(isPassword: true),

                SizedBox(height: screenHeight * 0.06),

// --- BOUTON OK (CORRIGÉ) ---
 _buildOkButton(context),

SizedBox(height: screenHeight * 0.04),
                // --- Texte de confidentialité ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: const Text(
                    'Pour des raisons de confidentialité, merci de ne pas choisir les nom et prénom de l\'enfant',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                
                // Espace avant le bouton "J'ai un compte"
                SizedBox(height: screenHeight * 0.15),

// Lignes 86-87
// --- Bouton "J'ai un compte" ---
_buildHaveAccountButton(context, screenWidth),
                
                // Espace en bas
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget pour le champ de texte blanc stylisé
  Widget _buildWhiteTextField({bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0), // Forme ovale
      ),
      child: TextField(
        obscureText: isPassword, // Masquer le texte pour le mot de passe
        decoration: const InputDecoration(
          border: InputBorder.none, // Supprime la bordure par défaut
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  // Widget pour le bouton OK
 // --- Widget pour le bouton OK (au centre) ---
 Widget _buildOkButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        debugPrint('Bouton OK pressé (Inscription: Pseudo/Mot de passe)');
        Navigator.push( context, MaterialPageRoute(
builder: (context) => const MenuScreen(), 
 ), 
);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple, 
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        minimumSize: const Size(100, 60), // Grande taille pour le bouton OK
      ),
      child: const Text(
        'OK',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

// --- Widget pour le bouton "J'ai un compte" (en bas) ---
Widget _buildHaveAccountButton(BuildContext context, double screenWidth) {
return ElevatedButton(
 onPressed: () {
// Navigue vers LoginScreen
 Navigator.push( context, MaterialPageRoute(
builder: (context) => const LoginScreen(), 
 ), 
);
 debugPrint('Bouton J\'ai un compte pressé');
 },
 style: ElevatedButton.styleFrom(
 backgroundColor: Colors.white,
 foregroundColor: Colors.deepPurple,
 elevation: 0,
 shape: RoundedRectangleBorder(
   borderRadius: BorderRadius.circular(25.0),
 ),
 minimumSize: Size(screenWidth * 0.7, 50),
),
child: const Text(
 'J\'ai un compte',
  style: TextStyle(
 fontSize: 18,
 fontWeight: FontWeight.bold,
color: Colors.blue, 
),
),
 );
 }
}