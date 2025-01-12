import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:inspire_me/model/quote.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();

  factory DbHelper() => _instance;

  DbHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'quotes.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE quotes (
        id TEXT PRIMARY KEY,
        content TEXT,
        author TEXT,
        tags TEXT,
        authorSlug TEXT,
        length INTEGER,
        dateAdded TEXT,
        dateModified TEXT
      )
    ''');
  }

  // Insert a Quote into the database
  Future<void> insertQuote(Quote quote) async {
    final db = await database;
    await db.insert(
      'quotes',
      quote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if duplicate
    );
  }

  // Retrieve all Quotes from the database
  Future<List<Quote>> getQuotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('quotes');

    return List.generate(maps.length, (i) {
      return Quote.fromMap(maps[i]);
    });
  }

  // Retrieve a single Quote by ID
  Future<Quote?> getQuoteById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'quotes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Quote.fromMap(maps.first);
    }
    return null;
  }

  // Delete a Quote by ID
  Future<void> deleteQuote(String id) async {
    final db = await database;
    await db.delete(
      'quotes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Update an existing Quote
  Future<void> updateQuote(Quote quote) async {
    final db = await database;
    await db.update(
      'quotes',
      quote.toMap(),
      where: 'id = ?',
      whereArgs: [quote.id],
    );
  }

  // Delete all Quotes
  Future<void> deleteAllQuotes() async {
    final db = await database;
    await db.delete('quotes');
  }
}
