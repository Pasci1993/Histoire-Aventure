import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'inscriptionscreen.dart';
import 'menuscreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _errorMessage = '';
  bool loading = false;

  @override
  void dispose() {
    pseudoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(BuildContext context) async {
    setState(() => _errorMessage = '');
    final pseudo = pseudoController.text.trim();
    final password = passwordController.text.trim();

    if (pseudo.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = "Veuillez remplir tous les champs.");
      return;
    }

    setState(() => loading = true);

    try {
      final email = "$pseudo@histoire-aventure.com"; // email fictif
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MenuScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? "Erreur inconnue";
      setState(() => _errorMessage = message);
    } finally {
      setState(() => loading = false);
    }
  }

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
              children: [
                SizedBox(height: screenHeight * 0.05),
                const Text(
                  'Déjà inscrit ? Saisis tes identifiants',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),

                _buildTextField('Pseudo', Icons.person, pseudoController),
                SizedBox(height: screenHeight * 0.04),
                _buildTextField('Mot de passe', Icons.lock, passwordController,
                    isPassword: true),
                const SizedBox(height: 10),

                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),

                const SizedBox(height: 20),
                loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : _buildOkButton(screenWidth),

                SizedBox(height: screenHeight * 0.25),
                _buildSignUpButton(screenWidth),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.black, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.deepPurple),
          prefixIcon: Icon(icon, color: Colors.deepPurple),
        ),
      ),
    );
  }

  Widget _buildOkButton(double screenWidth) {
    return ElevatedButton(
      onPressed: () => _handleLogin(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        minimumSize: Size(screenWidth, 56),
      ),
      child: const Text(
        'OK',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
    );
  }

  Widget _buildSignUpButton(double screenWidth) {
    return ElevatedButton(
      onPressed: () {
        // Navigue vers InscriptionScreen sans âge pour les utilisateurs "Pas encore inscrit"
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const InscriptionScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        minimumSize: Size(screenWidth, 50),
      ),
      child: const Text(
        'Pas encore inscrit ?',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }
}
