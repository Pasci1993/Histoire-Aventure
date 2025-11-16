import 'package:appli_histoire_aventure/models/child_profile.dart';
import 'package:appli_histoire_aventure/services/local_db_service.dart';
import 'package:appli_histoire_aventure/services/firebase_service.dart';
import 'package:uuid/uuid.dart'; // Nécessaire pour générer des IDs uniques

class ProfileRepository {
  final LocalDbService _localDbService = LocalDbService();
  final FirebaseService _firebaseService = FirebaseService();
  final Uuid _uuid = const Uuid();

  // --- 1. CREATION DE PROFIL (Inscription) ---
  Future<ChildProfile> createAndSaveProfile({
    required String name,
    required String ageRange,
  }) async {
    final newProfile = ChildProfile(
      id: _uuid.v4(), // Génère un ID unique pour la DB locale et Firebase
      name: name,
      ageRange: ageRange,
      lastActive: DateTime.now(),
    );

    // Sauvegarde en parallèle pour la meilleure performance
    await Future.wait([
      _localDbService.saveProfile(newProfile),
      _firebaseService.saveProfile(newProfile),
    ]);

    return newProfile;
  }

  // --- 2. MISE À JOUR DE LA PROGRESSION (Jeu terminé) ---
  Future<void> updateProfileProgress(ChildProfile profile) async {
    final updatedProfile = ChildProfile(
      id: profile.id,
      name: profile.name,
      ageRange: profile.ageRange,
      totalStars: profile.totalStars + 1, // Exemple : ajoute 1 étoile
      progress: profile.progress + 0.1, // Exemple : ajoute 10%
      trophiesWon: profile.trophiesWon,
      lastActive: DateTime.now(), // Met à jour l'horodatage
    );

    // Sauvegarde Locale IMMÉDIATE pour l'UX
    await _localDbService.saveProfile(updatedProfile);

    // Synchronisation Cloud en arrière-plan
    // Si la connexion échoue, nous pouvons implémenter une file d'attente de synchronisation.
    try {
      await _firebaseService.saveProfile(updatedProfile);
    } catch (e) {
      print("Erreur de synchronisation Firebase : $e");
      // TODO: Marquer ce profil comme "à synchroniser" localement
    }
  }

  // --- 3. RÉCUPÉRATION DU PROFIL (Au démarrage) ---
  Future<ChildProfile?> getProfile(String profileId) async {
    // 1. Essayer de récupérer rapidement en local
    ChildProfile? localProfile = await _localDbService.getProfile(profileId);

    // 2. Si on a rien en local (premier lancement, DB effacée, etc.), on va dans le cloud
    if (localProfile == null) {
      ChildProfile? cloudProfile = await _firebaseService.getProfile(profileId);
      if (cloudProfile != null) {
        // Sauvegarde localement pour les prochaines fois et le mode hors ligne
        await _localDbService.saveProfile(cloudProfile);
        return cloudProfile;
      }
    }
    // 3. Si on a le profil en local, on le retourne. 
    // On pourrait ajouter une vérification de la date 'lastActive' pour s'assurer que la version locale est la plus récente.
    return localProfile;
  }

  // --- 4. RÉCUPÉRATION DE TOUS LES PROFILS (Écran Paramètres) ---
  Future<List<ChildProfile>> getAllProfiles() async {
    // Dans la plupart des cas, la liste locale est suffisante et rapide
    return _localDbService.getAllProfiles();

    // Pour une application multi-appareils, on pourrait préférer un stream Firestore ici.
    // return _firebaseService.streamAllProfiles(); 
  }
}