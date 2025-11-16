import 'package:flutter/material.dart';

// Définition des couleurs basées sur la maquette
const Color _selectedBorderColor = Color(0xFF6DC043); // Vert pour la sélection (Success)
const Color _ageButtonColor = Colors.white; 
const Color _disabledColor = Color(0xFFE0E0E0); // Gris clair pour les boutons désactivés
const Color _profileOutlineColor = Colors.black; 
const Color _avatarBackgroundColor = Colors.orange; // Couleur du fond de l'avatar

class ParametresModalLandscape extends StatelessWidget {
  const ParametresModalLandscape({super.key});

  // Lance la modal
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ParametresModalLandscape(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Center(
        child: Container(
          // Dimensions fixes pour l'affichage paysage
          width: 750, 
          height: 480, 
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: Stack(
            children: [
              // Contenu principal de la modal
              _buildModalContent(context),
              
              // Bouton Fermer (X) en haut à gauche
              Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 30, color: Colors.black54),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              // Titre "Paramètres"
              const Positioned(
                top: 20,
                left: 60,
                child: Text(
                  'Paramètres',
                  style: TextStyle(
                    fontSize: 20, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.black54
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // --- SECTION PROFIL (Avatar et Ajouter) ---
        Container(
          padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profil Enfant Actuel
              _buildProfileItem(
                label: 'Enfant A',
                isCurrent: true,
                onTap: () {}, // Peut être utilisé pour changer de profil
              ),
              const SizedBox(width: 40),
              // Ajouter un Profil (Bloqué)
              _buildProfileItem(
                label: 'Ajouter un profil enfant',
                isAddButton: true,
                onTap: () {
                  // Message indiquant que la fonction est bloquée
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('L\'ajout de compte est temporairement désactivé.')),
                  );
                },
              ),
            ],
          ),
        ),
        
        // --- SECTION SÉLECTION DE L'ÂGE (Grisée) ---
        Expanded(
          child: Container(
            color: const Color(0xFFF3E5F5).withOpacity(0.5), // Fond légèrement mauve/gris
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sélectionner l\'âge',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
                ),
                const SizedBox(height: 15),
                // Ligne des boutons d'âge
                Wrap(
                  spacing: 15.0, 
                  runSpacing: 15.0, 
                  children: <Widget>[
                    _buildAgeButton('3-5 ans', isSelected: true), // Actif
                    _buildAgeButton('5-6 ans', isDisabled: true),
                    _buildAgeButton('6-7 ans', isDisabled: true),
                    _buildAgeButton('7-8 ans', isDisabled: true),
                    _buildAgeButton('9-10 ans', isDisabled: true),
                    _buildAgeButton('11+ ans', isDisabled: true),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget pour un élément de profil (Avatar ou Bouton Ajouter)
  Widget _buildProfileItem({
    required String label,
    bool isCurrent = false,
    bool isAddButton = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: isAddButton ? 80 : 90,
            height: isAddButton ? 80 : 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAddButton ? _disabledColor : _avatarBackgroundColor,
              border: Border.all(
                color: isAddButton ? Colors.grey.shade400 : _profileOutlineColor,
                width: 2,
              ),
              image: isCurrent && !isAddButton 
                  ? const DecorationImage(
                      image: AssetImage('assets/images/pinocchio_logo.png'), // Votre logo Pinocchio
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: isAddButton
                ? const Icon(Icons.add, size: 35, color: Colors.grey)
                : null,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isAddButton ? 12 : 14,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
              color: isAddButton ? Colors.grey : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour les boutons d'âge
  Widget _buildAgeButton(String label, {bool isSelected = false, bool isDisabled = false}) {
    final Color borderColor = isSelected ? _selectedBorderColor : Colors.grey.shade400;
    final Color backgroundColor = isDisabled ? _disabledColor : _ageButtonColor;
    final Color textColor = isDisabled ? Colors.grey.shade600 : Colors.black87;

    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor,
          width: isSelected ? 3 : 1,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected) const Icon(Icons.check, size: 18, color: _selectedBorderColor),
          ],
        ),
      ),
    );
  }
}