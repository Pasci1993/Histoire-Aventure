import 'package:appli_histoire_aventure/pages/ageselectionscreen.dart';
import 'package:appli_histoire_aventure/pages/loginscreen.dart';
import 'package:flutter/material.dart';

// Définir les couleurs du design directement dans le widget
class Registrationorloginscreen extends StatelessWidget {
  const Registrationorloginscreen({super.key});

  static const Color primaryPurple = Color(0xFF6A1B9A); // Violet foncé du fond (Approximation)
  static const Color buttonTextWhite = Colors.white;
  static const Color buttonFillWhite = Colors.white; // Remplissage du bouton "Nouveau"
  // Note: Flutter utilise le Material Design 3 par défaut.

  @override
  Widget build(BuildContext context) {
    // Media Query pour obtenir la taille de l'écran et adapter les espacements
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Un Scaffold est nécessaire pour définir la couleur de fond et la structure de la page
    return Scaffold(
      // Couleur de fond violette
      backgroundColor: primaryPurple, 
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // --- Section 1: Logo (sur fond blanc) ---
            Expanded(
              flex: 2, // Prend plus d'espace vertical
              child: Center(
                child: Container(
                  // Conteneur blanc derrière l'image
                  color: Colors.white, 
                  // padding vertical pour l'esthétique
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.05, 
                  ),
                  child: Image.asset(
                    // IMPORTANT : Assurez-vous que ce chemin d'asset est valide
                    'assets/images/logo3.png', 
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // --- Section 2: Boutons & Texte Légal (sur fond violet) ---
            Expanded(
              flex: 1, 
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  // Espacement uniforme entre les boutons et le texte légal
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // 1. Bouton "Je suis un nouveau aventurier" (Remplissage Blanc)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AgeSelectionScreen(),
                        ),
                      );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonFillWhite, // Remplissage blanc
                          foregroundColor: primaryPurple, // Texte violet
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 0, 
                        ),
                        child: const Text(
                          'Je suis un nouveau aventurier',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    // 2. Bouton "J'ai un compte" (Bordure Blanche)
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: OutlinedButton(
                        onPressed: () {
                           Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: buttonTextWhite, // Texte blanc
                          side: const BorderSide(
                            color: buttonFillWhite, // Bordure blanche
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text(
                          "J'ai un compte",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    // 3. Texte légal/Condition d'utilisation
                    Text(
                      "En sélectionnant l'une des options ci-dessus\nj'accepte les conditions générales d'utilisation et la\npolitique de confidentialité",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: buttonTextWhite.withOpacity(0.8), 
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}