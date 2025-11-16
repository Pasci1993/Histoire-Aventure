import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math'; // Pour la génération aléatoire

// Enum pour représenter les couleurs du jeu
enum GameColor {
  red,
  blue,
  yellow,
  green, // Ajout d'une couleur pour plus de variété
}

class ColorSortingGame extends StatefulWidget {
  const ColorSortingGame({super.key});

  @override
  State<ColorSortingGame> createState() => _ColorSortingGameState();
}

class _ColorSortingGameState extends State<ColorSortingGame> {
  // Liste des objets à trier (avec leur couleur)
  final List<GameColor> _itemsToDrag = [];
  // Nombre d'objets bien triés
  int _score = 0;
  // Nombre total d'objets à trier dans un niveau
  final int _totalItems = 5;

  // Cible de dépôt acceptée par chaque DragTarget
  final Map<GameColor, bool> _acceptedColors = {
    GameColor.red: false,
    GameColor.blue: false,
    GameColor.yellow: false,
    GameColor.green: false,
  };

  @override
  void initState() {
    super.initState();
    _resetGame(); // Initialise le jeu
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  // Réinitialise le jeu et génère de nouveaux objets
  void _resetGame() {
    setState(() {
      _score = 0;
      _itemsToDrag.clear();
      final random = Random();
      // Génère 5 objets de couleurs aléatoires
      for (int i = 0; i < _totalItems; i++) {
        _itemsToDrag.add(GameColor.values[random.nextInt(GameColor.values.length)]);
      }
      // Réinitialise l'état des zones de dépôt
      _acceptedColors.updateAll((key, value) => false);
    });
  }

  // Convertit une GameColor en une couleur Material Design
  Color _getMaterialColor(GameColor gameColor) {
    switch (gameColor) {
      case GameColor.red:
        return Colors.red;
      case GameColor.blue:
        return Colors.blue;
      case GameColor.yellow:
        return Colors.yellow;
      case GameColor.green:
        return Colors.green;
    }
  }

  // Affiche un dialogue de fin de jeu
  void _showGameEndDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Jeu Terminé !'),
          content: Text('Tu as trié $_score couleurs sur $_totalItems !'),
          actions: <Widget>[
            TextButton(
              child: const Text('Rejouer'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
                _resetGame(); // Réinitialise le jeu
              },
            ),
            TextButton(
              child: const Text('Retour au menu'),
              onPressed: () {
                Navigator.of(context).pop(); // Ferme le dialogue
                Navigator.of(context).pop(); // Retour à GameSelectionScreen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Nouveau fond d'écran pour le jeu
      backgroundColor: Colors.lightBlue[100], // Un fond bleu clair pour un jeu d'enfant
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              // --- En-tête : Bouton Retour et Score ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, color: Colors.indigo, size: 40),
                  ),
                  Text(
                    'Score : $_score / $_totalItems',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),

              // --- Zone des éléments à glisser ---
              Container(
                height: 100, // Hauteur fixe pour les objets à glisser
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.indigo.shade200, width: 2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _itemsToDrag.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final GameColor color = entry.value;
                    return Draggable<GameColor>(
                      data: color,
                      feedback: Material(
                        color: Colors.transparent,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: _getMaterialColor(color).withOpacity(0.7),
                          child: Icon(Icons.palette, color: Colors.white.withOpacity(0.8), size: 30),
                        ),
                      ),
                      childWhenDragging: Container(), // Cache l'original pendant le glissement
                      child: _acceptedColors[_itemsToDrag[index]]! 
                        ? Container() // Objet disparu si déjà accepté
                        : CircleAvatar(
                            radius: 30,
                            backgroundColor: _getMaterialColor(color),
                            child: const Icon(Icons.circle, color: Colors.white, size: 15), // Petite icône pour la démo
                          ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 30),

              // --- Zones de dépôt ---
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: GameColor.values.map((targetColor) {
                    return DragTarget<GameColor>(
                      onWillAcceptWithDetails: (details) => details.data == targetColor,
                      onAcceptWithDetails: (details) {
                        setState(() {
                          _score++;
                          // On marque l'objet comme "accepté" pour le faire disparaître
                          // Méthode simplifiée: on cherche et on supprime le premier objet de cette couleur
                          _itemsToDrag.remove(details.data);
                          if (_itemsToDrag.isEmpty) {
                            _showGameEndDialog();
                          }
                        });
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: _getMaterialColor(targetColor).withOpacity(0.2), // Fond transparent de la cible
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: candidateData.isNotEmpty ? _getMaterialColor(targetColor) : Colors.grey.shade400, // Bordure plus épaisse si un objet est au-dessus
                              width: candidateData.isNotEmpty ? 4 : 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.square, // Icône pour représenter le pot
                                color: _getMaterialColor(targetColor),
                                size: 50,
                              ),
                              Text(
                                targetColor.name.toUpperCase(),
                                style: TextStyle(
                                  color: _getMaterialColor(targetColor),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}