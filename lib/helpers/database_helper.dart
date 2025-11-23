import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/rental_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('carrental.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullName TEXT NOT NULL,
        nik TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        address TEXT NOT NULL,
        username TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE rentals(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        carId INTEGER NOT NULL,
        carName TEXT NOT NULL,
        carType TEXT NOT NULL,
        carImageUrl TEXT NOT NULL,
        carPricePerDay REAL NOT NULL,
        renterName TEXT NOT NULL,
        rentalDays INTEGER NOT NULL,
        startDate TEXT NOT NULL,
        totalCost REAL NOT NULL,
        status TEXT NOT NULL
      )
    ''');
  }

  Future<int> createUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUser(String username, String password) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserByNik(String nik, String password) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      where: 'nik = ? AND password = ?',
      whereArgs: [nik, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<bool> checkUsernameExists(String username) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    return maps.isNotEmpty;
  }

  Future<bool> checkNikExists(String nik) async {
    final db = await instance.database;
    final maps = await db.query('users', where: 'nik = ?', whereArgs: [nik]);
    return maps.isNotEmpty;
  }

  Future<int> createRental(Rental rental) async {
    final db = await instance.database;
    return await db.insert('rentals', rental.toMap());
  }

  Future<List<Rental>> getAllRentals() async {
    final db = await instance.database;
    final maps = await db.query('rentals', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => Rental.fromMap(maps[i]));
  }

  Future<Rental?> getRental(int id) async {
    final db = await instance.database;
    final maps = await db.query('rentals', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Rental.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateRental(Rental rental) async {
    final db = await instance.database;
    return await db.update(
      'rentals',
      rental.toMap(),
      where: 'id = ?',
      whereArgs: [rental.id],
    );
  }

  Future<int> updateRentalStatus(int id, String status) async {
    final db = await instance.database;
    return await db.update(
      'rentals',
      {'status': status},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
