import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InteractiveStoryScreenLandscape extends StatefulWidget {
  // Le chemin de l'histoire (ou l'ID) peut être passé comme paramètre
  final String storyId;

  const InteractiveStoryScreenLandscape({super.key, required this.storyId});

  @override
  State<InteractiveStoryScreenLandscape> createState() => _InteractiveStoryScreenLandscapeState();
}

class _InteractiveStoryScreenLandscapeState extends State<InteractiveStoryScreenLandscape> {
  // Simuler l'état actuel de l'histoire (peut être stocké dans un modèle ou un fichier JSON)
  String _currentText = "Le petit dragon bleu, Zippy, arrive au bord d'une rivière large. Pour atteindre l'autre côté où se trouve le trésor, il a deux options : traverser le pont de corde fragile ou chercher un chemin plus long à travers la forêt dense. Que fait Zippy ?";
  String _choiceA = "Traverser le pont fragile (Rapide mais dangereux)";
  String _choiceB = "Prendre le chemin de la forêt (Sûr mais lent)";

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

  // Logique pour gérer le choix de l'utilisateur
  void _handleChoice(String choice) {
    String newText;
    
    // Simule la progression de l'histoire
    if (choice == 'A') {
      newText = "Zippy traverse le pont ! Le pont tangue terriblement, mais il y arrive ! Ouf ! Il est sauf et a gagné du temps. Il continue son chemin vers le trésor. (Gagné : Temps) ";
      // Ici, on pourrait naviguer vers la suite de l'histoire (un autre écran)
    } else {
      newText = "Zippy prend le chemin de la forêt. Il rencontre un gentil écureuil qui lui donne des noisettes, mais il a perdu beaucoup de temps. Le trésor sera-t-il encore là ? (Perdu : Temps)";
      // Ici, on pourrait naviguer vers la suite de l'histoire (un autre écran)
    }

    setState(() {
      _currentText = newText;
      // Optionnel : Désactiver les choix après la première décision
      _choiceA = "Continuer...";
      _choiceB = ""; 
    });
    
    // Pour cet exemple, on navigue après un court délai pour que l'enfant puisse lire le résultat
    Future.delayed(const Duration(seconds: 4), () {
        // Normalement, vous naviguez ici vers la page suivante de l'histoire ou le tableau de bord
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
    });
  }

  // Widget utilitaire pour les boutons de décision
  Widget _buildChoiceButton({
    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
    // Bouton de décision, utilisant le style familier (blanc, bordure arrondie)
    return SizedBox(
      width: 300, 
      height: 60,
      child: ElevatedButton(
        onPressed: text == 'Continuer...' ? () => Navigator.pop(context) : onPressed, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(color: color, width: 3), // Bordure colorée pour accent
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A1B9A), // Fond violet de l'application
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              // --- 1. Bouton de sortie ---
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context), 
                  child: const Icon(Icons.exit_to_app, color: Colors.white, size: 40),
                ),
              ),

              const SizedBox(height: 20),

              // --- 2. Zone de l'histoire et Image (Utilise l'espace restant) ---
              Expanded(
                child: Row(
                  children: [
                    // Zone de l'image / Illustration (30% de l'écran)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1), // Placeholder visuel
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text("Image de la Scène", style: TextStyle(color: Colors.white70)),
                      ),
                    ),
                    
                    const SizedBox(width: 20),

                    // Zone du texte de l'histoire (70% de l'écran)
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95), // Fond presque blanc pour le texte
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          child: Text(
                            _currentText,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.black87,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // --- 3. Boutons de choix ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // Choix A (Couleur rose/rouge)
                  if (_choiceA.isNotEmpty)
                    _buildChoiceButton(
                      text: _choiceA,
                      onPressed: () => _handleChoice('A'),
                      color: const Color(0xFFFCC0C0), 
                    ),

                  // Choix B (Couleur verte/bleue, si différent de 'Continuer')
                  if (_choiceB.isNotEmpty)
                    _buildChoiceButton(
                      text: _choiceB,
                      onPressed: () => _handleChoice('B'),
                      color: const Color(0xFF6A1B9A), 
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}