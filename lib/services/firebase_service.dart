import 'package:appli_histoire_aventure/modeles/child_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Assurez-vous d'avoir le bon chemin

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection de référence
  CollectionReference get profilesCollection => _db.collection('child_profiles');

  // --- Opérations CRUD Firestore ---

  // 1. Sauvegarder/Mettre à jour un profil dans Firestore
  Future<void> saveProfile(ChildProfile profile) async {
    // Utilise l'ID du profil comme ID de document pour une référence facile
    return profilesCollection.doc(profile.id).set(profile.toMap(), SetOptions(merge: true));
  }

  // 2. Récupérer un profil spécifique
  Future<ChildProfile?> getProfile(String profileId) async {
    try {
      DocumentSnapshot doc = await profilesCollection.doc(profileId).get();
      if (doc.exists) {
        return ChildProfile.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // 3. Récupérer tous les profils (pour l'écran de gestion des comptes)
  Stream<List<ChildProfile>> streamAllProfiles() {
    return profilesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ChildProfile.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }
}