import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Utiliser MediaQuery pour obtenir la taille de l'écran (utile pour le padding)
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100], // Fond gris très clair pour l'arrière-plan
      appBar: AppBar(
        title: const Text('Menu', style: TextStyle(color: Colors.black, fontSize: 28)),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // --- Conteneur Principal Violet ---
              Container(
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
                        // Avatar
                        _buildUserAvatar(),

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
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets de construction ---

  Widget _buildUserAvatar() {
    // Simule l'avatar avec une bordure stylisée
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Bordure stylisée (Orange, Bleu, etc.)
        border: Border.all(
          color: Colors.orange, 
          width: 3.0,
        ),
        image: const DecorationImage(
          // Remplacez 'assets/avatar.png' par l'image de votre choix
          image: NetworkImage('https://via.placeholder.com/60/FFD700/000000?text=👶'), 
          fit: BoxFit.cover,
        ),
      ),
    );
  }

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
        'action': () => debugPrint('Parcours personnalisé démarré'),
      },
      {
        'title': 'Histoires interactives',
        'icon': Icons.book_rounded,
        'color': Colors.lightBlue,
        'action': () => debugPrint('Histoires interactives sélectionnées'),
      },
      {
        'title': 'Jeux éducatifs',
        'icon': Icons.gamepad_rounded,
        'color': Colors.greenAccent,
        'action': () => debugPrint('Jeux éducatifs sélectionnés'),
      },
      {
        'title': 'Progression',
        'icon': Icons.bar_chart_rounded,
        'color': Colors.orangeAccent,
        'action': () => debugPrint('Progression consultée'),
      },
    ];

    // Calculer la largeur de chaque carte (environ 1/3 de l'écran - padding)
    final cardWidth = screenWidth * 0.4;
    final cardHeight = 150.0;

    return SizedBox(
      height: cardHeight + 50, // Hauteur suffisante pour les cartes et le texte
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Défilement horizontal
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];

          return GestureDetector(
            onTap: item['action'],
            child: Container(
              width: cardWidth,
              margin: const EdgeInsets.only(right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- La Carte (Container blanc) ---
                  Container(
                    height: cardHeight,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: index == 0 ? Colors.white : Colors.white.withOpacity(0.95), // La première est pleine
                      borderRadius: BorderRadius.circular(15.0),
                      border: index != 0 ? Border.all(color: Colors.grey.shade300) : null, // Bordure subtile pour les autres
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 🎨 Icône ajoutée
                          Icon(item['icon'], size: 50, color: item['color']),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // --- Texte sous la Carte ---
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      item['title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}