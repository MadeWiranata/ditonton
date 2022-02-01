import 'dart:async';
import 'package:aplikasiditonton/data/models/movie_table.dart';
import 'package:aplikasiditonton/data/models/tv/tv_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:aplikasiditonton/data/datasources/tv/tv_local_data_source.dart';

class DatabaseHelper {
  static const String made = "";
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    //if (_database == null) {
    _database = await _initDb();
    //}
    return _database;
  }

  static const String _tblWatchlist = 'watchlist';

  Future<Database> _initDb() async {
    var hk;
    if (TVLocalDataSourceImpl.KelasApa == "movie") {
      hk = "/ditonton.db";
    } else {
      hk = "/tv.db";
    }
    final path = await getDatabasesPath();
    final databasePath = '$path$hk';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    if (TVLocalDataSourceImpl.KelasApa == "movie") {
      await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    } else {
      await db.execute('''
      CREATE TABLE  $_tblWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        poster_path TEXT
      );
    ''');
    }
    TVLocalDataSourceImpl.KelasApa = "";
  }

  Future<int> insertWatchlistTV(TVTable tv) async {
    TVLocalDataSourceImpl.KelasApa = "";
    final db = await database;
    return await db!.insert(_tblWatchlist, tv.toJson());
  }

  Future<int> removeWatchlistTV(TVTable tv) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTVById(int id) async {
    TVLocalDataSourceImpl.KelasApa = "";
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTV() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    TVLocalDataSourceImpl.KelasApa = "movie";
    final db = await database;
    return await db!.insert(_tblWatchlist, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    TVLocalDataSourceImpl.KelasApa = "movie";
    final db = await database;
    final results = await db!.query(
      _tblWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchlist);

    return results;
  }
}
