
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/user_model.dart';

late Database _db;
ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);

Future<void> initializeDataBase() async {
  WidgetsFlutterBinding.ensureInitialized();
  _db = await openDatabase(
    'user.db',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('''CREATE TABLE user(
        id INTEGER PRIMARY KEY,
        username TEXT,
        mail TEXT,
        password TEXT,
        islogin INTEGER)''');
    },
  );
}

Future<void> addUser(UserModel value) async {
  await _db.rawInsert(
    'INSERT INTO user(username, mail, password) VALUES(?,?,?)',
    [value.userName, value.mail, value.password],
  );
}

Future<void> getUser() async {
  userListNotifier.value.clear();
  final values = await _db.rawQuery('SELECT * FROM user');
  print('................................................................');
  print(values);
}

Future<UserModel?> validateUser(String userName, String password) async {
  final List<Map<String, dynamic>> users = await _db.query(
    'user',
    where: 'username = ? AND password = ?',
    whereArgs: [userName, password],
  );

  if (users.isNotEmpty) {
    int id = users.first['id'];
    await _db.update(
      'user',
      {'islogin': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
    return UserModel.fromJson(users.first);
  } else {
    return null;
  }
}

