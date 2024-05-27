import 'package:flutter_notepad_app_sqflite/models/notes.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesRepository {
  static Database? _database;
  static const dbName = 'notesDatabase';
  static const tableName = 'notesTable';
  static const dbVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        createdAt TEXT
      )
      '''
    );
  }

  static Future<int> insertNotes({required Note note}) async {
    Database db = await NotesRepository().database;
    return await db.insert(
      tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> getNotes() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  static Future<int> deleteNotes(int id) async {
    Database db = await NotesRepository().database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> updateNotes({required Note note}) async {
    Database db = await NotesRepository().database;
    return await db.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }
}
