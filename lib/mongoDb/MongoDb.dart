import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import '../util/modle.dart';
import 'constant.dart';

class MongoDatabase {
  static var db, UserCollection;

  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    UserCollection = db.collection(MONGO_collection);
    print(await UserCollection.find().toList());
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arryData = await UserCollection.find().toList();
    return arryData;
  }

  //
  // static Future<List<Map<String, dynamic>>> updatedata() async{
  //   final arryData = await UserCollection.update;
  //   return arryData;
  //
  //
  // }

  static Future<void> updatedata(id, _condition) async {
    var u = await UserCollection.findOne({"_id": id});

    u["condition"] = _condition;

    await UserCollection.save(u);
  }

  static delete(Welcome data) async {
    print(data.id);
    print("Now delete it");
    //await UserCollection.remove(data.id);
    await UserCollection.remove({"_id": data.id});
  }

  static update(
      Welcome data,
      ) async {
    var result = await UserCollection.findOne({"_id": data.id});
    result['task'] = data.task;
    await UserCollection.save(result);
  }

  static Future<String> insert(Welcome data) async {
    try {
      var result = await UserCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something Went Wrong";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
