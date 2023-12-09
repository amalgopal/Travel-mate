
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travel_mate/model/companions_model.dart';
import 'package:travel_mate/model/expense_model.dart';
import 'package:travel_mate/model/media_model.dart';
import 'package:travel_mate/model/trip_model.dart';

import '../../model/user_model.dart';

late Database _db;
ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);
ValueNotifier<List<TripModal>> tripListNotifier = ValueNotifier([]);
Future<void> initializeDataBase() async {
  WidgetsFlutterBinding.ensureInitialized();
  _db = await openDatabase(
    'user.db',
    version: 1,
    onCreate: (Database db, int version) async {
       db.execute('''CREATE TABLE user(
        id INTEGER PRIMARY KEY,
        image TEXT,
        username TEXT,
        mail TEXT,
        password TEXT,
        islogin INTEGER)''');

      db.execute('''CREATE TABLE trip (
            id INTEGER PRIMARY KEY,
            tripName TEXT,
            destination TEXT,
            budget TEXT,
            startingDate TEXT,
            endingDate TEXT,
            transport TEXT,
            travelPurpose TEXT,
            coverPic TEXT,
            userID INTEGER)''');

      db.execute('''CREATE TABLE companions (
              id INTEGER PRIMARY KEY,
              name TEXT, 
              number TEXT, 
              tripID INTEGER)''');

      db.execute('''CREATE TABLE expense(
            id INTEGER PRIMARY KEY,
            userID INTEGER ,
            tripID INTEGER ,
            spende TEXT ,
            amount INTEGER)''') ; 

      db.execute('''CREATE TABLE media(
            id INTEGER PRIMARY KEY,
            userID INTEGER ,
            tripID INTEGER ,
            mediaPic TEXT )''');      
    },
  );
}  
///////////Media pics////////
Future<int?> addMediapics(MediaModel value)async{
  
  final id = await _db.rawInsert('INSERT INTO media (userID,tripID,mediaPic) VALUES(?,?,?)',
  [value.userId,value.tripId,value.mediaImage]);
  

  return id;
}
//////////get media pics////
Future<List<Map<String,dynamic>>?> getmediapics (int tripId) async {
List<Map<String,dynamic>> mediapic =await _db.query('media',where: 'tripID=?',whereArgs: [tripId]) ;

if(mediapic.isNotEmpty){
return mediapic;

}
return null;

}
/////////////
 deletemedia(int? mediaid) async {
    await _db.rawDelete('DELETE FROM media WHERE id = ?', [mediaid]);
 }
/////////// Expense /////////////
Future<int?> addExpense(ExpenseModel value)async {
  
   final id =  await _db.rawInsert('INSERT INTO expense (userID,tripID,spende,amount) VALUES (?,?,?,?)', 
[value.userId,value.tripID,value.spende,value.amount] );

 return id;
} 
//////////
Future<List<Map<String, dynamic>>?> getExpenses(int tripid)async{
   List<Map<String, dynamic>> expenses= await _db.query('expense',where: 'tripID=?',whereArgs: [tripid]);
 if(expenses.isNotEmpty){
   return expenses;
 }
 return null;
}
////get total Expense by trip id

Future<int>getTotalExpense(int tripId)async{
     List<Map<String, dynamic>> expenses= await _db.query('expense',where: 'tripID=?',whereArgs: [tripId]);
     num total=0;
     for(int i=0;i<expenses.length;i++){
      total += expenses[i]['amount'];
     }
     return total.toInt();
}
//// grt balance ///////
Future<int>getbalance(int tripid)async{
  
  final expense =await getTotalExpense(tripid);
  final List<Map<String, dynamic>> tripList=await _db.query("trip",where: 'id=?',whereArgs: [tripid]);
  final trip=tripList.first;
  final budget=int.parse(trip['budget']);
  final balance=budget-expense;
  return balance;
 
}

///////////// COMPANIONS ///////////////

 addCompanions(Map<String, dynamic> companion) async {
    _db.insert('companions', companion);
  }
///////////// TRIP function ////////////
  addTrip(TripModal value, List<Map<String, dynamic>> data) async {
    int id = await _db.rawInsert(
        'INSERT INTO trip (tripName,destination,budget,startingDate,endingDate,transport,travelPurpose,coverPic,userID) VALUES (?,?,?,?,?,?,?,?,?)',
        [
          value.tripName,
          value.destination,
          value.budget,
          value.startingDate,
          value.endingDate,
          value.transport,
          value.travelPurpose,
          value.coverPic,
          value.userID
        ]);
        

    for (int i = 0; i < data.length; i++) {
      // ignore: unnecessary_null_comparison
      data != null ? data[i]['tripID'] = id : null;
      addCompanions(data[i]);
      print(data[i]);
    }
    getAllTrip();
  }

  getAllTrip() async {
    tripListNotifier.value.clear();
    final values = await _db.rawQuery('SELECT * FROM trip'); //(* = columns)
    print(values);
  }


  //ongoing trip..........................................................
  Future<TripModal?> getOnGoingTrip(int userId) async {
  TripModal? obj;

  DateTime currentDate = DateTime.now();
  String convertedDate = DateFormat('dd MMM yyyy').format(currentDate); // Change date format

  var trips = await _db.query('trip',
      where: 'userID=? AND startingDate<=? AND endingDate>=?',
      whereArgs: [userId, convertedDate, convertedDate]);

  for (var map in trips) {
    if (map['startingDate'] != null) {
      obj = TripModal.fromJson(map);

      // Fetch companions for this trip and add them to obj
      var companions = await _db
          .query('companions', where: 'tripID = ?', whereArgs: [obj.id]);

      obj.companions = companions
          .map((companionMap) => CompanionModel.fromJson(companionMap))
          .toList();
    }
  }
  return obj;
}

  

//upcoming trip................................................................
 Future<List<TripModal>> getUpcomingTrip(int userId) async {
  List<TripModal> tripsList = [];

  DateTime currentDate = DateTime.now();
  String convertedDate = DateFormat('dd MMM yyyy').format(currentDate); // Change date format

  List trips = await _db.query('trip',
      where: 'userID=? AND startingDate>? AND endingDate>?',
      whereArgs: [userId, convertedDate, convertedDate]);

  for (var map in trips) {
    if (map['startingDate'] != null) {
      TripModal trip = TripModal.fromJson(map);

      // Fetch companions for this trip and add them to obj
      var companions = await _db
          .query('companions', where: 'tripID = ?', whereArgs: [trip.id]);

      trip.companions = companions
          .map((companionMap) => CompanionModel.fromJson(companionMap))
          .toList();
      tripsList.add(trip);
    }
  }
  return tripsList;
}


//recent trip...................................................................
 Future<List<TripModal>> getRecentTrip(int userId) async {
  List<TripModal> tripsList = [];

  DateTime currentDate = DateTime.now();
  String convertedDate = DateFormat('dd MMM yyyy').format(currentDate); // Change date format

  List trips = await _db.query('trip',
      where: 'userID=? AND endingDate<?', whereArgs: [userId, convertedDate]);

  for (var map in trips) {
    if (map['endingDate'] != null) {
      TripModal trip = TripModal.fromJson(map);

      // Fetch companions for this trip and add them to obj
      var companions = await _db
          .query('companions', where: 'tripID = ?', whereArgs: [trip.id]);

      trip.companions = companions
          .map((companionMap) => CompanionModel.fromJson(companionMap))
          .toList();
      tripsList.add(trip);
    }
  }
  return tripsList;
}

 
  //update trip.......................................................
  updateTrip(
    TripModal trip,
  ) async {
    await _db.update(
      'trip',
      trip.toJson(), // Convert the TripModal object to a map.
      where: 'id = ?',
      whereArgs: [trip.id],
    );
    // await _db.delete('companions',where: 'tripID = ?',whereArgs: [trip.id]);
  }
  
  //delete trip.......................................................
  deleteTrip(int tripId) async {
    await _db.rawDelete('DELETE FROM trip WHERE id = ?', [tripId]);
    await _db.rawDelete('DELETE FROM companions WHERE tripID = ?', [tripId]);
    getAllTrip();
  }
//--------get all trip details 
  Future<List<TripModal>> alltripDetails(int userId) async {
  
    const addtable = 'trip'; // Replace with your actual table name
  final ColumnUserId = 'userID'; // Replace with your actual column name
  final Columnstartdate = 'startingDate'; // Replace with your actual column name

  final result= await _db.query(addtable,
      where: '$ColumnUserId = ?',
      whereArgs: [userId],
      orderBy: '$Columnstartdate ASC');
      final search=result.map((e) => TripModal.fromJson(e)).toList();
      return search;
}


/////////////////  USER function ////////////////
Future<int>addUser(UserModel value) async {
  
  int id =await _db.rawInsert(
    'INSERT INTO user(image, username, mail, password, islogin) VALUES(?,?,?,?,?)',
    [value.image,value.username, value.mail, value.password,1],
  
  );
   print(value.username);
   //value.id = id;
    return id;
}

Future<void> getUser() async {
  userListNotifier.value.clear();
  final values = await _db.rawQuery('SELECT * FROM user');
  
  print(values);
}
//validate User when login................................
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
//------------------------------------------------------------------------------------------------
//checking name when signin if name already exists.....................
  Future<bool> checkIfNameExists(String name) async {
    final List users = await _db.query(
      'user',
      where: 'username = ?',
      whereArgs: [name],
    );
    return users.isNotEmpty;
  }

//when user login make isLogin=1..........................................
  getUserLogged() async {
    final user = await _db.query('user', where: 'isLogin=1', limit: 1);
    if (user.isEmpty) {
      return null;
    } else {
      return UserModel.fromJson(user.first);
    }
  }
  //when user signou make isLogin=0................................................
  signoutUser() async {
    final List<Map<String, dynamic>> user =
        await _db.query('user', where: 'isLogin = ?', whereArgs: [1], limit: 1);
    if (user.isNotEmpty) {
      int id = user.first['id'];
      _db.update('user', {'isLogin': 0}, where: 'id = ?', whereArgs: [id]);
    }
  }
/////////////Edit user info functions/////////
  
updateUserinfo(String columnNAme,String newValue,int userId)async{
  print("image path:-$newValue");
 final value= await _db.update('user', {columnNAme:newValue},
  where: 'id=?',whereArgs: [userId]);
  print("Value:=$value");
}

/////update profile and username in homepage/////

Future<Map<String,dynamic>> getlogedProfile() async{
  List<Map<String,dynamic>> map =
  await _db.query('user',where: 'isLogin = 1');
  return map.first;
}