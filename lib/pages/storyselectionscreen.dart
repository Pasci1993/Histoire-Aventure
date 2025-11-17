import 'package:appli_histoire_aventure/pages/parametrespage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appli_histoire_aventure/pages/interactivestoryscreen.dart';

class StorySelectionScreen extends StatefulWidget {
  const StorySelectionScreen({super.key});

  @override
  State<StorySelectionScreen> createState() => _StorySelectionScreenState();
}

class _StorySelectionScreenState extends State<StorySelectionScreen> {
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
    // Réinitialise l'orientation par défaut (Portrait) lorsque l'écran est quitté
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  // Widget utilitaire pour les cartes interactives (Histoires, Jeux, Progression)
  Widget _buildContentCard({
    required String label,
    required IconData icon,
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
              // Icône de verrouillage ou Contenu
              if (isLocked)
                const Icon(
                  Icons.lock_outline,
                  size: 50,
                  color: Color(0xFF6A1B9A),
                )
              else
                Icon(icon, size: 50, color: const Color(0xFF6A1B9A)),

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
    // La carte violette utilise toute la largeur et hauteur disponible dans le Center
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
          width:
              MediaQuery.of(context).size.width *
              0.95, // Presque toute la largeur
          height:
              MediaQuery.of(context).size.height *
              0.85, // Presque toute la hauteur
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: const Color(0xFF6A1B9A), // Fond violet
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            children: <Widget>[
              // --- Ligne d'en-tête (Titre, Profil, Tout débloquer) ---
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 1. Bouton/Image de Profil
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

                  const SizedBox(width: 20),

                  // 2. Titre (Sélection de l'histoire/Menu Principal)
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Menu Principal', // Texte par défaut pour le tableau de bord
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const Spacer(), // Pousse les éléments restants à droite
                  // 3. Bouton "Tout débloquer"
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Ouverture du magasin de déverrouillage...',
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

              // --- Ligne des Cartes de Contenu ---
              Expanded(
                child: Row(
                  children: <Widget>[
                    // 1. Démarrer le parcours personnalisé
                    _buildContentCard(
                      label: 'Démarrer l\'histoire',
                      icon: Icons.auto_stories,
                      onTap: () {},
                    ),

                    // 2. Histoires interactives
                    _buildContentCard(
                      label: 'Histoire 1',
                      icon: Icons.book,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const InteractiveStoryScreenLandscape(
                                  storyId: 'story1',
                                ),
                          ),
                        );
                      },
                    ),
                    _buildContentCard(
                      label: 'Histoire 2',
                      icon: Icons.book,
                      isLocked: true,
                      onTap: () {},
                    ),

                    // 4. Progression (Verrouillé, comme dans la maquette)
                    _buildContentCard(
                      label: 'Histoire 3',
                      icon: Icons.book,
                      isLocked: true,
                      onTap: () {},
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
