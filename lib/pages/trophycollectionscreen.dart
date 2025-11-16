import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Définition de la structure d'un trophée
class Trophy {
  final int id;
  final String name;
  final IconData icon; // Icône de base pour le trophée (forme)
  final bool isEarned; // Vrai si le joueur l'a gagné
  final Color earnedColor; // Couleur si gagné

  Trophy({
    required this.id,
    required this.name,
    required this.icon,
    this.isEarned = false,
    required this.earnedColor,
  });
}

class TrophyCollectionScreenLandscape extends StatefulWidget {
  const TrophyCollectionScreenLandscape({super.key});

  @override
  State<TrophyCollectionScreenLandscape> createState() => _TrophyCollectionScreenLandscapeState();
}

class _TrophyCollectionScreenLandscapeState extends State<TrophyCollectionScreenLandscape> {
  // Liste des trophées simulée
  final List<Trophy> _trophies = [
    Trophy(id: 1, name: '1ère Histoire', icon: Icons.diamond_outlined, isEarned: true, earnedColor: Colors.amber),
    Trophy(id: 2, name: '10 Étoiles', icon: Icons.star_border, isEarned: true, earnedColor: Colors.cyan),
    Trophy(id: 3, name: 'Jeu de Tri', icon: Icons.diamond_outlined, isEarned: false, earnedColor: Colors.grey),
    Trophy(id: 4, name: '50% Progrès', icon: Icons.auto_stories, isEarned: true, earnedColor: Colors.deepPurple),
    Trophy(id: 5, name: 'Quiz Parfait', icon: Icons.person, isEarned: false, earnedColor: Colors.grey),
    Trophy(id: 6, name: 'Jeu de Forme', icon: Icons.star_border, isEarned: false, earnedColor: Colors.grey),

    Trophy(id: 7, name: 'Collection A', icon: Icons.diamond_outlined, isEarned: true, earnedColor: Colors.green),
    Trophy(id: 8, name: 'Collection B', icon: Icons.star_border, isEarned: false, earnedColor: Colors.grey),
    Trophy(id: 9, name: 'Collection C', icon: Icons.diamond_outlined, isEarned: true, earnedColor: Colors.orange),
    Trophy(id: 10, name: 'Collection D', icon: Icons.person, isEarned: false, earnedColor: Colors.grey),
    Trophy(id: 11, name: 'Collection E', icon: Icons.star_border, isEarned: true, earnedColor: Colors.pinkAccent),
    Trophy(id: 12, name: 'Collection F', icon: Icons.person, isEarned: false, earnedColor: Colors.grey),
  ];

  @override
  void initState() {
    super.initState();
    // Force le mode Paysage
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Réinitialise l'orientation par défaut
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  // Widget pour afficher un seul trophée (gagné ou ombre)
  Widget _buildSingleTrophy(Trophy trophy) {
    // Couleur si le trophée est gagné, ou couleur de l'ombre si non
    final Color displayColor = trophy.isEarned 
        ? trophy.earnedColor 
        : Colors.black.withOpacity(0.3); // Ombre grise

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Le trophée lui-même
        Icon(
          trophy.icon,
          size: 60,
          color: displayColor,
        ),
        // La base du trophée (simulant le socle)
        Container(
          width: 50,
          height: 10,
          decoration: BoxDecoration(
            color: displayColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Couleur du fond marron/rouge de la maquette
    const Color shelfBackgroundColor = Color(0xFF8B0000); 
    const Color woodColor = Color(0xFFFFCC66); // Couleur du bois pour l'étagère

    // Diviser les trophées en deux rangées de 6
    final List<Trophy> topRow = _trophies.sublist(0, 6);
    final List<Trophy> bottomRow = _trophies.sublist(6, 12);

    // Fonction pour créer une rangée d'étagère
    Widget buildTrophyShelf(List<Trophy> trophies) {
      return Column(
        children: [
          // Les trophées sur l'étagère
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: trophies.map(_buildSingleTrophy).toList(),
          ),
          const SizedBox(height: 10),
          // L'étagère en bois
          Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
              color: woodColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: shelfBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // --- Fond à motifs (simulé) ---
            Center(
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/wavy_pattern.png', // Image de motif ondulé (doit être ajoutée)
                  repeat: ImageRepeat.repeat,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
            
            // --- Contenu principal (Étagères et Trophées) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTrophyShelf(topRow),
                  const Spacer(flex: 1), 
                  buildTrophyShelf(bottomRow),
                ],
              ),
            ),

            // --- Bouton Fermer (X) en haut à gauche ---
            Positioned(
              top: 15,
              left: 15,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}