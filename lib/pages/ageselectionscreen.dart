import 'package:appli_histoire_aventure/pages/inscriptionscreen.dart';
import 'package:flutter/material.dart';

class AgeSelectionScreen extends StatelessWidget {
  const AgeSelectionScreen({super.key});

  // Liste des âges à afficher
  final List<Map<String, String>> ageOptions = const [
    {'number': '1', 'word': 'Un'},
    {'number': '2', 'word': 'Deux'},
    {'number': '3', 'word': 'Trois'},
    {'number': '4', 'word': 'Quatre'},
    {'number': '5', 'word': 'Cinq'},
    {'number': '6', 'word': 'Six'},
    {'number': '7', 'word': 'Sept'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar stylisée en violet
      appBar: AppBar(
        title: const Text('Niveau', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: false,
      ),
      // Le corps de l'écran avec un fond blanc
      body: SingleChildScrollView(
      // Ajout d'un padding pour un meilleur espacement autour du contenu
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        // Aligner les éléments au début de la colonne (en haut)
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Espace pour la barre violette sous l'AppBar
          Container(
            height: 40,
            color: Colors.deepPurple,
            // Le ClipPath permet de simuler la découpe de l'écran (encoche/poinçon)
            child: ClipPath(
              clipper: NotchClipper(),
              child: Container(
                color: Colors.white, // Le fond qui vient après la barre violette
              ),
            ),
          ),
      
          // Texte de la question
          const Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              'Quel âge a votre enfant?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Couleur bleue du texte
              ),
            ),
          ),
          
          // Boucle pour créer les boutons
          ...ageOptions.map((option) {
            return _buildAgeButton(context, option['number']!, option['word']!);
          }),
        ],
      ),
      ),
    );
  }

  Widget _buildAgeButton(BuildContext context, String number, String word) {
    // Le widget Padding ajoute un espace vertical entre les boutons
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 60, // Hauteur fixe pour le bouton
        decoration: BoxDecoration(
          // Bords arrondis
          borderRadius: BorderRadius.circular(8.0),
          // Bordure grise comme dans l'image
          border: Border.all(color: Colors.grey.shade400, width: 2.0),
        ),
        // GestureDetector simule un bouton cliquable
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InscriptionScreen(),
                        ),
                      );
            debugPrint('Sélectionné : $word');
          },
          // Style pour retirer le fond et l'ombre par défaut d'ElevatedButton
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black, // Couleur du splash (effet de pression)
            elevation: 0, // Pas d'ombre
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.zero, // Retire le padding interne par défaut
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Espace à gauche
              const SizedBox(width: 20),
              // Texte du numéro (gros, ombré)
              Text(
                number,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  // Ombre pour l'effet 3D "squelette"
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2, 2),
                      blurRadius: 1,
                    ),
                  ],
                  color: Colors.white, // Fond blanc du numéro
                ),
              ),
              // Espace entre le numéro et le mot
              const SizedBox(width: 20),
              // Texte du mot
              Text(
                word,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  // Ombre similaire pour le mot
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(1, 1),
                      blurRadius: 0.5,
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

// Classe personnalisée pour dessiner la découpe simulant l'encoche de l'écran
class NotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Commence en haut à gauche
    path.lineTo(0, size.height);
    
    // Simuler un léger arc pour l'encoche
    double notchWidth = 40.0;
    double startX = (size.width / 2) - (notchWidth / 2);
    double endX = (size.width / 2) + (notchWidth / 2);
    double notchHeight = 10.0; // Profondeur de l'encoche

    // Courbe vers le centre pour l'encoche
    path.lineTo(startX - 10, size.height);
    path.cubicTo(
      startX, size.height, // Point de contrôle 1
      startX, size.height - notchHeight, // Point de contrôle 2
      size.width / 2, size.height - notchHeight, // Milieu de l'encoche
    );
    path.cubicTo(
      endX, size.height - notchHeight, // Point de contrôle 3
      endX, size.height, // Point de contrôle 4
      endX + 10, size.height, // Fin de l'encoche
    );

    // Va en bas à droite
    path.lineTo(size.width, size.height);
    // Remonte en haut à droite
    path.lineTo(size.width, 0);
    // Ferme le chemin
    path.close();
    return path;
  }

  @override
  bool shouldReclip(NotchClipper oldClipper) => false;
}