import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProgresScreenPortrait extends StatefulWidget {
  const ProgresScreenPortrait({super.key});

  @override
  State<ProgresScreenPortrait> createState() =>
      _ProgresScreenPortraitState();
}

class _ProgresScreenPortraitState
    extends State<ProgresScreenPortrait> {
  static const Color aquaColor = Color(0xFF6DE8E4);

  // Données simulées pour l'enfant
  final double _progressPercentage = 0.72; // 72%
  final int _totalStars = 45;
  final int _trophiesWon = 3;

  @override
  void initState() {
    super.initState();
    // Forcer le portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Réinitialiser l'orientation par défaut
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  // Message d'encouragement selon le pourcentage
  String _getEncouragementMessage(double percentage) {
    if (percentage >= 0.9) return 'Super travail ! 🏆';
    if (percentage >= 0.7) return 'Bravo, continue comme ça ! 🌟';
    if (percentage >= 0.5) return 'Bien commencé, tu peux faire encore mieux ! 😊';
    return 'Allez, tu vas y arriver ! 💪';
  }

  // Carte circulaire avec diagramme et message
  Widget _buildProgressCard({
    required String label,
    required double percentage,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.6), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: percentage,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Text(
                '${(percentage * 100).toInt()}%',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            _getEncouragementMessage(percentage),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  // Carte simple pour étoiles ou trophées
  Widget _buildSimpleStatCard({
    required String label,
    required int value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
            decoration:
                BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 36),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                value.toString(),
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: color),
              )
            ],
          )
        ],
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
              _buildProgressCard(
                  label: 'Progrès général', percentage: _progressPercentage, color: Colors.indigo),
              _buildSimpleStatCard(
                  label: 'Étoiles', value: _totalStars, icon: Icons.star_rate_rounded, color: Colors.orange.shade800),
              _buildSimpleStatCard(
                  label: 'Trophées', value: _trophiesWon, icon: Icons.emoji_events, color: const Color(0xFF6A1B9A)),
            ],
          ),
        ),
      ),
    );
  }
}
