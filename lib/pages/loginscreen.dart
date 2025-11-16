import 'package:appli_histoire_aventure/pages/menuscreen.dart';
import 'package:appli_histoire_aventure/pages/showforgotpassworddialog.dart';
import 'package:flutter/material.dart';
// 🚨 Assurez-vous d'importer le fichier où se trouve InscriptionScreen
import 'inscriptionscreen.dart'; 
// 🚨 Assurez-vous d'importer le fichier contenant la fonction showForgotPasswordDialog

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.deepPurple,
        width: screenWidth,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.05),

                const Text(
                  'Déjà inscrit : saisis tes identifiants',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: screenHeight * 0.06),
                
                // --- Champ Pseudo ---
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Pseudo', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                _buildWhiteTextField(),

                SizedBox(height: screenHeight * 0.04),

                // --- Champ Mot de passe ---
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Mot de passe', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                _buildWhiteTextField(isPassword: true),
                
                const SizedBox(height: 10),

                // --- Lien Mot de passe oublié (Cliquable) ---
                _buildForgotPasswordLink(context), // Appel à la nouvelle fonction

                SizedBox(height: screenHeight * 0.06),

                // --- Bouton OK ---
                _buildOkButton(context, screenWidth),

                SizedBox(height: screenHeight * 0.25),

                // --- Bouton "Pas encore inscrit?" ---
                _buildSignUpButton(context, screenWidth), 
                
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- NOUVEAU : Fonction pour le lien Mot de passe oublié (appelle la modale) ---
  Widget _buildForgotPasswordLink(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          // 🚨 Appel à la fonction showForgotPasswordDialog pour afficher la modale
          showForgotPasswordDialog(context); 
        },
        child: const Text(
          'Mot de passe oublié',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            decoration: TextDecoration.underline,
            decorationColor: Colors.white,
          ),
        ),
      ),
    );
  }

  // --- Fonctions de construction réutilisables ---

  Widget _buildWhiteTextField({bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildOkButton(BuildContext context, double screenWidth) {
    return ElevatedButton(
      onPressed: () {Navigator.push( context, MaterialPageRoute(
builder: (context) => const MenuScreen(), 
 ), 
);
        debugPrint('Bouton OK pressé (Login)');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple, 
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        minimumSize: const Size(100, 60),
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

  Widget _buildSignUpButton(BuildContext context, double screenWidth) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InscriptionScreen(), 
          ),
        );
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
        'Pas encore inscrit?',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }
}