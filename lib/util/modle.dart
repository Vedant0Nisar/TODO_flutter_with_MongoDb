import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Welcome welcomeFromJson(str) => Welcome.fromJson(json.decode(str));

welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {

  ObjectId? id;
  String? task;
  bool? condition;

  Welcome({
    this.id,
    this.task,
    this.condition,
  });


  //
  // String? get condition => condition;
  // set condition(String? _condition) => condition = _condition;
  //



  factory Welcome.fromJson(Map<String, dynamic> json) =>
      Welcome(
        id: json["_id"],
        task: json["task"],
        condition: json["condition"],

      );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "task": task,
        "condition": false,
      };

}


