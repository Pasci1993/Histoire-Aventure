import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProgressionScreenLandscape extends StatefulWidget {
  const ProgressionScreenLandscape({super.key});

  @override
  State<ProgressionScreenLandscape> createState() => _ProgressionScreenLandscapeState();
}

class _ProgressionScreenLandscapeState extends State<ProgressionScreenLandscape> {
  // Définition de la couleur Aqua/Sarcelle de la maquette
  static const Color aquaColor = Color(0xFF6DE8E4); // Couleur similaire au fond de la maquette 
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  // Widget utilitaire pour les cartes circulaires (Progrès, Étoiles, Trophées)
  Widget _buildCircularStatCard({
    required String label,
    required IconData icon,
    VoidCallback? onTap,
    required Color color, // Couleur d'accentuation
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Le grand cercle blanc
            Container(
              width: 150, // Taille du cercle
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.5), width: 5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                // Placeholder pour le contenu du cercle (icône)
                child: Icon(icon, size: 70, color: color),
              ),
            ),
            
            const SizedBox(height: 15),
            
            // Le petit rectangle de texte sous le cercle
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color, width: 2),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Fond derrière la carte
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95, // Presque toute la largeur
          height: MediaQuery.of(context).size.height * 0.85, // Presque toute la hauteur
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: aquaColor, // Fond Bleu Aqua/Sarcelle
            borderRadius: BorderRadius.circular(25.0),
            // Un dégradé léger pour ressembler à la maquette
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                aquaColor.withOpacity(0.9),
                aquaColor,
                aquaColor.withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // --- En-tête (Titre et Bouton Fermer) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Titre
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0),
                    child: Text(
                      'Progression',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004D40), // Vert foncé pour contraste
                      ),
                    ),
                  ),
                  
                  // Bouton Fermer (X)
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close, 
                      color: Color(0xFF004D40), // Vert foncé
                      size: 35,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // --- Ligne des Statistiques Circulaires ---
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // 1. Progrès (Icône de ligne/cible)
                    _buildCircularStatCard(
                      label: 'Progrès',
                      icon: Icons.track_changes,
                      color: const Color(0xFF1A237E), // Bleu marine
                      onTap: () {
                      },
                    ),
                    
                    // 2. Étoiles (Icône d'étoile)
                    _buildCircularStatCard(
                      label: 'Étoiles',
                      icon: Icons.star_rate_rounded,
                      color: Colors.orange.shade800, // Orange vif
                      onTap: () {
                      },
                    ),
                    
                    // 3. Trophées (Icône de coupe)
                    _buildCircularStatCard(
                      label: 'Trophées',
                      icon: Icons.emoji_events,
                      color: const Color(0xFF6A1B9A), // Couleur violette classique
                      onTap: () {
                      },
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