import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProgresScreenLandscape extends StatefulWidget {
  const ProgresScreenLandscape({super.key});

  @override
  State<ProgresScreenLandscape> createState() => _ProgresScreenLandscapeState();
}

class _ProgresScreenLandscapeState extends State<ProgresScreenLandscape> {
  // Définition de la couleur Aqua/Sarcelle de la maquette
  static const Color aquaColor = Color(0xFF6DE8E4); 
  static const Color darkAccentColor = Color(0xFF004D40); // Vert foncé pour le texte

  // Données simulées de progression
  final double _progressPercentage = 0.75; // 75%
  final int _totalStars = 45;
  final int _trophiesWon = 3;

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

  // Widget utilitaire pour les cartes circulaires de statistiques
  Widget _buildCircularStatCard({
    required String label,
    required Color color,
    required Widget contentWidget, // Widget dynamique pour le contenu (Progrès, Étoiles, Trophées)
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Le grand cercle blanc
          Container(
            width: 150, 
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
              child: contentWidget, // Le contenu dynamique est placé ici
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
    );
  }

  // Contenu spécifique pour le Progrès (avec indicateur circulaire)
  Widget _buildProgressContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircularProgressIndicator(
            value: _progressPercentage, // 0.0 à 1.0
            strokeWidth: 15,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo), // Bleu marine
          ),
        ),
        Text(
          '${(_progressPercentage * 100).toInt()}%',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
      ],
    );
  }

  // Contenu spécifique pour les Étoiles
  Widget _buildStarsContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star_rate_rounded, size: 60, color: Colors.orange.shade800),
        Text(
          '$_totalStars',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
          ),
        ),
      ],
    );
  }

  // Contenu spécifique pour les Trophées
  Widget _buildTrophiesContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.emoji_events, size: 60, color: const Color(0xFF6A1B9A)),
        Text(
          '$_trophiesWon',
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
          ),
        ),
      ],
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
            color: aquaColor, 
            borderRadius: BorderRadius.circular(25.0),
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
                  const Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0),
                    child: Text(
                      'Progression',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: darkAccentColor, 
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.close, 
                      color: darkAccentColor, 
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
                    // 1. Progrès (Pourcentage d'évolution)
                    _buildCircularStatCard(
                      label: 'Progrès',
                      color: Colors.indigo,
                      contentWidget: _buildProgressContent(),
                    ),
                    
                    // 2. Étoiles (Nombre total)
                    _buildCircularStatCard(
                      label: 'Étoiles',
                      color: Colors.orange.shade800,
                      contentWidget: _buildStarsContent(),
                    ),
                    
                    // 3. Trophées (Nombre total)
                    _buildCircularStatCard(
                      label: 'Trophées',
                      color: const Color(0xFF6A1B9A),
                      contentWidget: _buildTrophiesContent(),
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