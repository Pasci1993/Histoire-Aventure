import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';
import 'menuscreen.dart';

class InscriptionScreen extends StatefulWidget {
  final String? ageNumber;
  final String? ageWord;

  const InscriptionScreen({super.key, this.ageNumber, this.ageWord});

  @override
  State<InscriptionScreen> createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {
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

  Future<void> _handleSignUp(BuildContext context) async {
    setState(() => _errorMessage = '');

    final pseudo = pseudoController.text.trim();
    final password = passwordController.text.trim();

    if (pseudo.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = "Veuillez remplir tous les champs.");
      return;
    }

    setState(() => loading = true);

    try {
      debugPrint('Inscription: tentative pour pseudo="$pseudo"');
      final email = "$pseudo@histoire-aventure.com"; // email fictif
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final uid = userCredential.user!.uid;

      try {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'uid': uid,
          'pseudo': pseudo,
          'age_number': widget.ageNumber ?? '',
          'age_word': widget.ageWord ?? '',
          'created_at': Timestamp.now(),
        });

        debugPrint('Profil Firestore créé pour uid=$uid');
      } catch (e) {
        debugPrint('Erreur lors de l\'écriture Firestore pour uid=$uid : $e');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Inscription OK, mais profil non sauvegardé (permissions Firestore).',
              ),
            ),
          );
        }
      }

      // Show a short confirmation to the user (if not already shown by the
      // Firestore error branch).
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Inscription réussie !')));

        // Replace the whole navigation stack so MenuScreen becomes the app root
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const MenuScreen()),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = e.message ?? 'Erreur inconnue';
      debugPrint('FirebaseAuthException during signup: $message');
      setState(() => _errorMessage = message);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur d\'inscription: $message')),
        );
      }
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
        title: const Text('Inscription', style: TextStyle(color: Colors.black)),
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
                  'Bienvenue ! Saisis les informations pour t\'inscrire.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                if (widget.ageNumber != null && widget.ageWord != null)
                  Text(
                    "Âge choisi : ${widget.ageNumber} (${widget.ageWord})",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                SizedBox(height: screenHeight * 0.03),
                _buildTextField('Pseudo', Icons.person, pseudoController),
                SizedBox(height: screenHeight * 0.03),
                _buildTextField(
                  'Mot de passe',
                  Icons.lock,
                  passwordController,
                  isPassword: true,
                ),
                SizedBox(height: screenHeight * 0.03),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                SizedBox(height: screenHeight * 0.03),
                loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : _buildOkButton(screenWidth),
                SizedBox(height: screenHeight * 0.04),
                _buildHaveAccountButton(screenWidth),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.deepPurple, fontSize: 18),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.deepPurple),
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        ),
      ),
    );
  }

  Widget _buildOkButton(double screenWidth) {
    return ElevatedButton(
      onPressed: () => _handleSignUp(context),
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
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildHaveAccountButton(double screenWidth) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
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
        'J\'ai un compte',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
