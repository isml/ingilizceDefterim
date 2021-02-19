import 'dart:io';

import 'package:ingilizcedefterim/models/sentenceModel.dart';
import 'package:ingilizcedefterim/models/wordModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;

class Db {

  
    static Database _db;
  
    final String tableWord = 'Words';
    final String tableSentence = 'Sentences';
  
    final String columnId = 'id';
    final String columnTr = 'tr';
    final String columnEng = 'eng';
  


  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ingilizceDefter.db');
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    
    //String path =  join(documentsDirectory.path, 'ingilizceDefter.db');
    var myDb = await openDatabase(path, version: 3, onCreate: _onCreate);
    return myDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableWord($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnTr TEX,$columnEng TEXT)');
    await db.execute(
        'CREATE TABLE $tableSentence($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnTr TEX,$columnEng TEXT)');
  }

  Future<int> deleteWord(int id) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawDelete('DELETE FROM $tableWord WHERE $columnId= $id');
    });
  }

  Future<int> deleteSentence(int id) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn
          .rawDelete('DELETE FROM $tableSentence WHERE $columnId= $id');
    });
  }

  Future<int> updateWord(Word word) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawUpdate(
          'UPDATE $tableWord SET $columnTr= \'${word.tr}\',$columnEng= \'${word.eng}\'');
    });
  }

  Future<int> updateSentence(Sentence sentence) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawUpdate(
          'UPDATE $tableSentence SET $columnTr= \'${sentence.tr}\',$columnEng= \'${sentence.eng}\'');
    });
  }

  void SaveWord(Word word) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO $tableWord ($columnTr,$columnEng) VALUES (' +
              '\'' +
              word.tr +
              '\'' +
              ',' +
              '\'' +
              word.eng +
              '\'' +
              ')');
    });
  }
  
  void SaveSentence(Sentence sentence) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO $tableSentence ($columnTr,$columnEng) VALUES (' +
              '\'' +
              sentence.tr +
              '\'' +
              ',' +
              '\'' +
              sentence.eng +
              '\'' +
              ')');
    });
  }

  Future<List<Word>> getWords() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROm Words');
    List<Word> words = List();
    for (int i = 0; i < list.length; i++) {
      words.add(Word(list[i]['id'], list[i]['tr'].toString(), list[i]['eng'].toString(),
         ));
    }
    return words;
  }
  Future<List<Sentence>> getSentences() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROm Sentences');
    List<Sentence> sentences = List();
    for (int i = 0; i < list.length; i++) {
      sentences.add(Sentence(list[i]['id'], list[i]['tr'].toString(), list[i]['eng'].toString(),
         ));
    }
    return sentences;
  }

  getApplicationDocumentsDirectory() {}
}
