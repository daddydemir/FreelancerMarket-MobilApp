// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/_User.dart';

class DatabaseHelper {
  Database? db;

  Future<Database?> get DB async {
    db ??= await initializeDb();
    return db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "fm.db");
    var fm = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return fm;
  }

  FutureOr<void> createDb(Database db, int version) async {
    await db.execute(
        "create table Users(id integer, username text, name text, surname text, mail text, image text , token text , role text)");
  }

  Future<List<Users>> getUsers() async {
    var db = await DB;
    var result = await db?.query("Users");
    return List.generate(result!.length, (i) {
      return Users.fromObject(result[i]);
    });
  }

  Future insert(Users u) async {
    var db = await DB;

    var result = await db?.rawInsert(
        'insert into Users(id,username,name,surname,mail,image,token,role) values (?,?,?,?,?,?,?,?)',
        [
          u.id,
          u.username,
          u.name,
          u.surname,
          u.mail,
          u.image,
          u.token,
          u.role
        ]);
    return result;
  }

  Future delete(int id) async {
    var db = await DB;
    var result = await db?.rawDelete('delete from Users where id= $id');
    return result;
  }
}
