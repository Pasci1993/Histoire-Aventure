import 'package:appli_histoire_aventure/pages/parametrespage.dart';
import 'package:appli_histoire_aventure/pages/progressionscreen.dart';
import 'package:flutter/material.dart';
import 'package:appli_histoire_aventure/pages/ageselectionscreen.dart';
import 'package:appli_histoire_aventure/pages/storyselectionscreen.dart';
import 'package:appli_histoire_aventure/pages/gameselectionscreen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Utiliser MediaQuery pour obtenir la taille de l'écran (utile pour le padding)
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculer la hauteur disponible sous l'AppBar pour remplir la page
    final availableHeight =
        MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top -
        32; // 32 = padding vertical (16 + 16)

    return Scaffold(
      backgroundColor:
          Colors.grey[100], // Fond gris très clair pour l'arrière-plan
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          // Remplir toute la hauteur disponible pour que le menu occupe la page
          height: availableHeight,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple, // Fond violet
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // --- Header (Avatar et Bouton Débloquer) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ParametresModalLandscape(),
      ),
    );
  },
  child: Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2),
      image: const DecorationImage(
        image: AssetImage('assets/images/logo3.png'),
        fit: BoxFit.cover,
      ),
    ),
  ),
),
                  // Bouton "Tout débloquer"
                  _buildUnlockButton(),
                ],
              ),

              const SizedBox(height: 30),

              // --- Liste des Cartes de Menu (Scrollable horizontalement) ---
              _buildMenuCards(context, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets de construction ---


  Widget _buildUnlockButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint('Bouton Tout débloquer pressé');
        // Logique pour l'achat ou l'accès premium
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      child: const Text(
        'Tout débloquer',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black54, // Couleur du texte
        ),
      ),
    );
  }

  Widget _buildMenuCards(BuildContext context, double screenWidth) {
    // Données des éléments du menu
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Démarre le parcours personnalisé',
        'icon': Icons.star,
        'color': Colors.white,
        'action': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AgeSelectionScreen()),
        ),
      },
      {
        'title': 'Histoires interactives',
        'icon': Icons.book_rounded,
        'color': Colors.lightBlue,
        'action': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StorySelectionScreen()),
        ),
      },
      {
        'title': 'Jeux éducatifs',
        'icon': Icons.gamepad_rounded,
        'color': Colors.greenAccent,
        'action': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GameSelectionScreen()),
        ),
      },
      {
        'title': 'Progression',
        'icon': Icons.bar_chart_rounded,
        'color': Colors.orangeAccent,
        'action': () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProgressionScreenPortrait(),
          ),
        ),
      },
    ];

    // Hauteur de chaque carte
    final cardHeight = 100.0;

    // Maintenant on retourne une liste verticale qui prend l'espace restant
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];

          final VoidCallback? action = item['action'] as VoidCallback?;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: action,
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 15.0),
                padding: const EdgeInsets.all(12.0),
                height: cardHeight,
                decoration: BoxDecoration(
                  color: index == 0
                      ? Colors.white
                      : Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(15.0),
                  border: index != 0
                      ? Border.all(color: Colors.grey.shade300)
                      : null,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icône à gauche
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item['icon'], size: 36, color: item['color']),
                    ),
                    const SizedBox(width: 12),
                    // Texte et description
                    Expanded(
                      child: Text(
                        item['title'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: index == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
