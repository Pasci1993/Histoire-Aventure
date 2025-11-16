import 'package:appli_histoire_aventure/pages/loginscreen.dart';
import 'package:appli_histoire_aventure/pages/menuscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import pour le type User
// Import du service

// Classe du widget pour la page d'inscription
class InscriptionScreen extends StatefulWidget {
  const InscriptionScreen({super.key});

  @override
  State<InscriptionScreen> createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
  // Contrôleurs pour récupérer les valeurs des champs de texte
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- Logique d'inscription ---
  Future<void> _handleSignUp(BuildContext context) async {
    setState(() {
      _errorMessage = ''; // Réinitialise le message d'erreur
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez remplir tous les champs.';
      });
      return;
    }

    // Appel au service Firebase
    final result = await _authService.signUp(email: email, password: password);

    if (result is User) {
      // Inscription réussie : Navigation vers l'écran principal
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MenuScreen()),
        );
      }
    } else if (result is String) {
      // Échec de l'inscription : Afficher l'erreur
      setState(() {
        _errorMessage = result;
      });
    }
  }

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

                const Text(
                  'Bienvenue ! Saisis les informations pour t\'inscrire.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // --- Champ Email ---
                _buildTextField(
                  context,
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.person,
                  keyboardType: TextInputType.emailAddress,
                ),

                SizedBox(height: screenHeight * 0.03),

                // --- Champ Mot de passe ---
                _buildTextField(
                  context,
                  controller: _passwordController,
                  labelText: 'Mot de passe',
                  icon: Icons.lock,
                  isPassword: true,
                ),

                SizedBox(height: screenHeight * 0.04),
                
                // --- Affichage de l'erreur Firebase ---
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      _errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                // --- Bouton OK ---
                _buildOkButton(context),

                SizedBox(height: screenHeight * 0.05),

                // --- Bouton "J'ai un compte" ---
                _buildHaveAccountButton(context, screenWidth),

                // Espace en bas pour l'esthétique
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Widget pour les champs de texte ---
  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.deepPurple, fontSize: 20),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.deepPurple),
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          border: InputBorder.none,
          // Rendre l'input plus grand
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0), 
        ),
      ),
    );
  }

  // --- Widget pour le bouton OK (Inscription) ---
  Widget _buildOkButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleSignUp(context), // Appel à la fonction Firebase
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
    Navigator.of(context).pushReplacement( // Utilisation de pushReplacement pour remplacer l'écran actuel
      MaterialPageRoute(
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
    ),
  ),
);
}
}

class FirebaseAuthService {
  Future signUp({required String email, required String password}) async {}
}