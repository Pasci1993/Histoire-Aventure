import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Enum pour représenter la qualité de l'étoile gagnée
enum StarQuality {
  gold, // Parfait (Étoile pleine/complète)
  silver, // Moyen (Étoile à moitié pleine)
  bronze, // Acceptable (Étoile contour ou simple)
}

// Modèle de données pour une activité complétée
class CompletedActivity {
  final String title;
  final StarQuality quality;
  final String date;

  CompletedActivity({
    required this.title,
    required this.quality,
    required this.date,
  });
}

class StarsScreenLandscape extends StatefulWidget {
  const StarsScreenLandscape({super.key});

  @override
  State<StarsScreenLandscape> createState() => _StarsScreenLandscapeState();
}

class _StarsScreenLandscapeState extends State<StarsScreenLandscape> {
  // Couleur du fond rose pâle/saumon de la maquette
  static const Color pinkSalmonColor = Color(0xFFE9967A); 
  static const Color darkAccentColor = Color(0xFF6A1B9A); // Violet foncé

  // Données simulées d'activités
  final List<CompletedActivity> _activities = [
    CompletedActivity(title: 'Histoire : Le Dragon Bleu', quality: StarQuality.gold, date: '12/11/25'),
    CompletedActivity(title: 'Jeu : Tri des couleurs', quality: StarQuality.silver, date: '13/11/25'),
    CompletedActivity(title: 'Histoire : La Forêt Magique', quality: StarQuality.gold, date: '14/11/25'),
    CompletedActivity(title: 'Jeu : Les Formes', quality: StarQuality.bronze, date: '15/11/25'),
    CompletedActivity(title: 'Histoire : La Montagne', quality: StarQuality.silver, date: '15/11/25'),
  ];

   @override
  void initState() {
    super.initState();
    // Force le mode portrait dès l'entrée
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
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

  // Retourne l'icône de l'étoile en fonction de sa qualité
  Widget _getStarIcon(StarQuality quality) {
    switch (quality) {
      case StarQuality.gold:
        return const Icon(Icons.star, color: Colors.amber, size: 30); // Étoile pleine (Parfait)
      case StarQuality.silver:
        return Icon(Icons.star_half, color: Colors.blueGrey.shade300, size: 30); // Moitié pleine (Moyen)
      case StarQuality.bronze:
        return Icon(Icons.star_border, color: Colors.brown.shade400, size: 30); // Contour (Acceptable)
    }
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
            color: pinkSalmonColor, 
            borderRadius: BorderRadius.circular(25.0),
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
                      'Détails des Étoiles',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: darkAccentColor, 
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close, 
                        color: darkAccentColor, 
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // --- Zone de la liste des activités ---
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                    itemCount: _activities.length,
                    itemBuilder: (context, index) {
                      final activity = _activities[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                        ),
                        child: Row(
                          children: [
                            // Icône d'étoile basée sur la qualité
                            _getStarIcon(activity.quality),
                            const SizedBox(width: 20),
                            // Nom de l'activité
                            Expanded(
                              child: Text(
                                activity.title,
                                style: const TextStyle(fontSize: 18, color: Colors.black87),
                              ),
                            ),
                            // Date de complétion
                            Text(
                              activity.date,
                              style: const TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}