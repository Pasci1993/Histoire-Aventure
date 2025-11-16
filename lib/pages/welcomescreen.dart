import 'package:appli_histoire_aventure/pages/registrationorloginscreen.dart';
import 'package:flutter/material.dart';


// Classe pour l'écran de démarrage
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    // Scaffold fournit la structure de base (AppBar, body, etc.)
    return Scaffold(
      // La couleur de fond est blanche comme dans votre dernier design
      backgroundColor: Colors.white,
      body: Center(
        // Utilisation d'une colonne pour empiler le logo et le bouton verticalement
        child:SingleChildScrollView(
        child: Column(
          // Centre le contenu verticalement
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // --- 1. Logo "Histoire & Aventure" ---
            // On utilise Image.asset pour charger l'image du logo depuis le dossier 'assets'
            Image.asset(
              'assets/images/logo.png', 
              // Assurez-vous d'utiliser le bon chemin et nom de fichier
              width: 300, // Ajustez la taille selon vos besoins
            ),

            // Ajoute un espace vertical entre le logo et le bouton
            const SizedBox(height: 100),

            // --- 2. Bouton d'action ---
            // Le bouton est un Elevated Button pour l'action principale
            SizedBox(
              width: 250, // Définit la largeur du bouton
              height: 50, // Définit la hauteur du bouton
              child: ElevatedButton(
                onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Registrationorloginscreen(),
                        ),
                      );
                    },
                style: ElevatedButton.styleFrom(
                  // Style des coins arrondis
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), 
                  ),
                  // Couleur de fond du bouton (ex: bleu clair pour correspondre au logo)
                  backgroundColor: const Color(0xFF4FC3F7), 
                ),
                child: const Text(
                  'Get start', // Ou 'Déjà inscrit ?'
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}