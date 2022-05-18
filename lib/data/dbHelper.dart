// ignore_for_file: prefer_is_empty, file_names, avoid_print

import 'dart:async';

import 'package:freelancer_market/models/sql_user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DbHelper{
  Database? _db;

  Future<Database?> get db async{
    // ignore: prefer_conditional_assignment
    if(_db==null){
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async{
    String dbPath = join(await getDatabasesPath(),"fm.db");
    var fmDb = await openDatabase(dbPath,version:1, onCreate:createDb);
    
    return fmDb;
  }

  void createDb(Database db, int version) async{
    await db.execute("Create table Users(id integer , username text , password text , name text, surname text, mail text, image text ,token text , role text)");
    //await db.rawInsert('insert into Users (id,username,password,token) values(1,"demir","mehmet12345","henuzTokenYok")');
    // veri tababında tablo oluşturuluyor 
    // ilk kayıt yapılıyor
  }

  Future<SqlUser?> checkUser(SqlUser user) async{
    Database? db = await this.db;
    List<Map<String,Object?>> maps = await db!.query("Users",columns:["id","username","password","token"],where:"id=?",whereArgs:[user.id]);
    if(maps.length > 0){
      print("dolu gitti");
      return SqlUser.fromMap(maps.first);
    }
    return null;
  }

  Future<List<SqlUser>> getUser() async{
    Database? db = await this.db;
    var result = await db?.query("Users");
    return List.generate(result!.length,(i){
      return SqlUser.forDbfromObject(result[i]);
    });
  }

  Future insert(SqlUser user) async{
    Database? db = await this.db;
    //var result = await db?.insert("Users" , user.toMap());
    var result = await db?.rawInsert('insert into Users (id,username,password, name, surname, mail, image, token ,role ) values(?,?,?,?,?,?,?,?,?)' , [user.id , user.username , user.password , user.name, user.surname, user.mail, user.image, user.token , user.role]);
    return result;
  }

  Future update(SqlUser user) async{
    Database? db = await this.db;
    var result = await db?.update("Users" , user.toMap(), where:"id=?",whereArgs: [user.id]);
    return result;
  }

  Future<int?> delete(int id) async{
    Database? db = await this.db;
    var result = await db?.rawDelete("delete from Users where id=$id");

    return result;
  }
}
