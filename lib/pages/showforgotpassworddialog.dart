import 'package:flutter/material.dart';

// Fonction pour afficher le dialogue modale "Mot de passe oublié"
Future<void> showForgotPasswordDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    // Empêche la fermeture en cliquant en dehors
    barrierDismissible: false, 
    builder: (BuildContext dialogContext) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          // Couleur marron/orangé foncé pour le fond de la modale
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 140, 75, 30), 
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // --- Bouton Fermer (X) ---
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.deepPurple, 
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ),
              
              const SizedBox(height: 10),

              // --- Champ Pseudo ---
              _buildPseudoTextField(),
              
              const SizedBox(height: 30),

              // --- Bouton Réinitialiser ---
              _buildResetButton(dialogContext),

              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}

// Widget pour le champ de texte "Pseudo" dans la modale
Widget _buildPseudoTextField() {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25.0),
    ),
    child: const TextField(
      decoration: InputDecoration(
        hintText: 'Pseudo',
        hintStyle: TextStyle(
            color: Color.fromARGB(255, 190, 190, 190), 
            fontSize: 18),
        border: InputBorder.none,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      ),
      style: TextStyle(color: Colors.black),
    ),
  );
}

// Widget pour le bouton Réinitialiser dans la modale
Widget _buildResetButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      debugPrint('Tentative de réinitialisation');
      // Fermer le dialogue
      Navigator.of(context).pop();
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue, 
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      minimumSize: const Size(150, 50),
    ),
    child: const Text(
      'Réinitialiser',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    ),
  );
}