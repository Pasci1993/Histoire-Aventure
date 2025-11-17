import 'package:appli_histoire_aventure/pages/progresscreen.dart';
import 'package:appli_histoire_aventure/pages/starsscreen.dart';
import 'package:appli_histoire_aventure/pages/trophycollectionscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Écrans de destination simulés
class ProgresDetailScreen extends StatelessWidget {
  const ProgresDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail Progrès')),
      body: const Center(child: Text('Ici le détail du progrès')),
    );
  }
}

class StarsDetailScreen extends StatelessWidget {
  const StarsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail Étoiles')),
      body: const Center(child: Text('Ici le détail des étoiles')),
    );
  }
}

class TrophiesDetailScreen extends StatelessWidget {
  const TrophiesDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail Trophées')),
      body: const Center(child: Text('Ici le détail des trophées')),
    );
  }
}

// Écran principal de progression en portrait
class ProgressionScreenPortrait extends StatefulWidget {
  const ProgressionScreenPortrait({super.key});

  @override
  State<ProgressionScreenPortrait> createState() =>
      _ProgressionScreenPortraitState();
}

class _ProgressionScreenPortraitState
    extends State<ProgressionScreenPortrait> {
  static const Color aquaColor = Color(0xFF6DE8E4);

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
    // Réinitialise l'orientation par défaut à la sortie
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  // Carte cliquable pour chaque statistique
  Widget _buildStatCard({
    required String label,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.6), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 36),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Progression',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: screenWidth,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: aquaColor,
            borderRadius: BorderRadius.circular(20),
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
          child: ListView(
            children: [
              _buildStatCard(
                label: 'Progrès',
                icon: Icons.track_changes,
                color: const Color(0xFF1A237E),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProgresScreenPortrait(),
                    ),
                  );
                },
              ),
              _buildStatCard(
                label: 'Étoiles',
                icon: Icons.star_rate_rounded,
                color: Colors.orange.shade800,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StarsScreenLandscape(),
                    ),
                  );
                },
              ),
              _buildStatCard(
                label: 'Trophées',
                icon: Icons.emoji_events,
                color: const Color(0xFF6A1B9A),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrophyCollectionScreenLandscape(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
