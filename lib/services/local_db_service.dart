import 'package:appli_histoire_aventure/modeles/child_profile.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
// Assurez-vous d'avoir le bon chemin

class LocalDbService {
  static Database? _database;
  static const String tableName = 'profiles';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'child_app_db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // Créer la table des profils enfants
        return db.execute(
          '''
          CREATE TABLE $tableName(
            id TEXT PRIMARY KEY, 
            name TEXT, 
            ageRange TEXT, 
            totalStars INTEGER, 
            trophiesWon INTEGER, 
            progress REAL,
            lastActive TEXT
          )
          ''',
        );
      },
    );
  }

  // --- Opérations CRUD SQLite ---

  // 1. Insérer ou Mettre à jour un profil localement
  Future<void> saveProfile(ChildProfile profile) async {
    final db = await database;
    await db.insert(
      tableName,
      profile.toMap(),
      // Remplace si l'ID existe déjà (utile pour les mises à jour)
      conflictAlgorithm: ConflictAlgorithm.replace, 
    );
  }

  // 2. Récupérer un profil spécifique
  Future<ChildProfile?> getProfile(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ChildProfile.fromMap(maps.first);
    }
    return null;
  }

  // 3. Récupérer tous les profils locaux (pour l'écran de sélection)
  Future<List<ChildProfile>> getAllProfiles() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return ChildProfile.fromMap(maps[i]);
    });
  }

  // 4. Supprimer un profil
  Future<void> deleteProfile(String id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}