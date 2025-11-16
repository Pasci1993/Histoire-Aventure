import 'package:appli_histoire_aventure/pages/colorsortinggame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameSelectionScreenLandscape extends StatefulWidget {
  const GameSelectionScreenLandscape({super.key});

  @override
  State<GameSelectionScreenLandscape> createState() =>
      _GameSelectionScreenLandscapeState();
}

class _GameSelectionScreenLandscapeState
    extends State<GameSelectionScreenLandscape> {
  @override
  void initState() {
    super.initState();
    // Force le mode Paysage au démarrage
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Ne pas réinitialiser l'orientation pour rester en paysage après la fin du jeu
    super.dispose();
  }

  // Widget utilitaire pour les cartes de jeu
  Widget _buildGameCard({
    required String label,
    required Widget iconOrImage, // Peut être une icône ou une image
    bool isLocked = false,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: isLocked ? null : onTap, // Désactive le tap si verrouillé
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Contenu (Icône de verrouillage ou logo/icône du jeu)
              if (isLocked)
                const Icon(
                  Icons.lock_outline,
                  size: 50,
                  color: Color(0xFF6A1B9A),
                )
              else
                iconOrImage, // Affiche l'icône ou l'image passée

              const SizedBox(height: 10),

              // Texte descriptif
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isLocked ? Colors.grey : const Color(0xFF6A1B9A),
                  fontWeight: isLocked ? FontWeight.normal : FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: const Color(0xFF6A1B9A), // Fond violet
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            children: <Widget>[
              // --- Ligne d'en-tête (Profil, Titre, Tout débloquer) ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 1. Bouton/Image de Profil (retour à l'écran précédent)
                  GestureDetector(
                    onTap: () => Navigator.pop(context), // Retour au Dashboard
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/placeholder_profile.png',
                          ), // Votre image de profil
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  // 2. Titre "Jeux éducatifs"
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Jeux éducatifs',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // 3. Bouton "Tout débloquer"
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Ouverture du magasin de déverrouillage des jeux...',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text(
                        'Tout débloquer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6A1B9A),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // --- Ligne des Cartes de Jeux ---
              Expanded(
                child: Row(
                  children: <Widget>[
                    // 1. Jeu de Tri des Couleurs (ou "Sélectionner un jeu")
                    _buildGameCard(
                      label: 'Jeu de Tri des Couleurs',
                      iconOrImage: Image.asset(
                        'assets/images/color_sorting_logo.png', // Chemin vers le logo de votre jeu
                        height: 50, // Ajustez la taille du logo
                        width: 50,
                      ),
                      onTap: () {
                        // Navigation vers le jeu de tri des couleurs
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ColorSortingGame(),
                          ),
                        );
                      },
                    ),

                    // 2. Autre jeu (avec icône générique)
                    _buildGameCard(
                      label: 'Jeu des Formes',
                      iconOrImage: const Icon(
                        Icons.category,
                        size: 50,
                        color: Color(0xFF6A1B9A),
                      ),
                      onTap: () {},
                    ),

                    // 3. Jeu verrouillé
                    _buildGameCard(
                      label: 'Jeu de Mémoire',
                      iconOrImage: const Icon(
                        Icons.memory,
                        size: 50,
                        color: Color(0xFF6A1B9A),
                      ),
                      isLocked: true,
                    ),

                    // 4. Autre jeu verrouillé
                    _buildGameCard(
                      label: 'Jeu de Calcul',
                      iconOrImage: const Icon(
                        Icons.calculate,
                        size: 50,
                        color: Color(0xFF6A1B9A),
                      ),
                      isLocked: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
