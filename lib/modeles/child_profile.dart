class ChildProfile {
  final String id; // Utilisé comme ID de document Firestore et clé primaire SQLite
  final String name;
  final String ageRange; // Ex: '3-5 ans', '5-6 ans'
  final int totalStars;
  final int trophiesWon;
  final double progress; // Pourcentage de progression (0.0 à 1.0)
  final DateTime lastActive;

  ChildProfile({
    required this.id,
    required this.name,
    required this.ageRange,
    this.totalStars = 0,
    this.trophiesWon = 0,
    this.progress = 0.0,
    required this.lastActive,
  });

  // Convertit un ChildProfile en Map pour Firestore et SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ageRange': ageRange,
      'totalStars': totalStars,
      'trophiesWon': trophiesWon,
      'progress': progress,
      'lastActive': lastActive.toIso8601String(), // Conversion pour le stockage
    };
  }

  // Crée un ChildProfile à partir d'un Map (Firestore ou SQLite)
  factory ChildProfile.fromMap(Map<String, dynamic> map) {
    return ChildProfile(
      id: map['id'],
      name: map['name'],
      ageRange: map['ageRange'],
      totalStars: map['totalStars'] ?? 0,
      trophiesWon: map['trophiesWon'] ?? 0,
      progress: (map['progress'] as num?)?.toDouble() ?? 0.0,
      lastActive: DateTime.parse(map['lastActive']),
    );
  }
}