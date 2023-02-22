//  dashboard








// FULLY COMPLETED BY 20 FEB 2023...........

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart' as M;

import '../mongoDb/MongoDb.dart';
import '../util/dialog_box_updated.dart';
import '../util/dialogbox_add.dart';
import '../util/modle.dart';
import '../util/todo_tile.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  var _TASK_ENTERED_IN_TEXTFIELD = new TextEditingController();
  bool isloading = true;





  checkBoxChanged(Welcome data) {
    //  print({data.condition});
    setState(() {
      data.condition = !data.condition!;
      MongoDatabase.updatedata(data.id, data.condition);
      print(data.condition);
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'All Tasks',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue.shade100,
        elevation: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: FloatingActionButton(
          onPressed: CreateNewTask,
          tooltip: 'Add Task',
          child: const Icon(Icons.add_task),
        ),
      ),
      body: Visibility(
        visible: isloading,
        child: Container(
          color: Colors.blue.shade50,
          child: FutureBuilder(
              future: MongoDatabase.getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else

                if (snapshot.hasData) {
                  // length of to do list
                  // var totalData = snapshot.data.length;
                  //print("Total data " + totalData.toString());

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final mongo_data = Welcome.fromJson(snapshot.data[index]);

                      // bool pass from db to todotile 'taskcompletd' funct
                      var str = ("${mongo_data.condition}");
                      bool toBoolean(String str, [bool strict = false]) {
                        if (strict == true) {
                          return str == '1' || str == 'true';
                        }
                        return str != '0' && str != 'false' && str != '';
                      }

                      return TodoTile(
                        taskName: ("${mongo_data.task}"),
                        taskCompleted: toBoolean(str),
                        onChanged: (value) => checkBoxChanged(Welcome.fromJson(snapshot.data[index]),),
                        editfunction: (value) => editbyId(Welcome.fromJson(snapshot.data[index])),
                        deleteFunction: (context) => deletebyId(Welcome.fromJson(snapshot.data[index])),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("No Data Connection"));
                }
              }),
        ),
      ),
    );
  }

  void CreateNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _TASK_ENTERED_IN_TEXTFIELD,
          onsave: submitData,
          oncancel: () {
            Navigator.of(context).pop();
            _TASK_ENTERED_IN_TEXTFIELD.clear();
          },
        );
      },
    );
  }

  // mongodb add
  Future<void> submitData() async {

    // get data
    var _id = M.ObjectId();
    final title = _TASK_ENTERED_IN_TEXTFIELD.text;


    // store data in 'data' variable
    final data = Welcome(id: _id, task: title);


    // insert/submit data to mongodb db server
    final result = await MongoDatabase.insert(data);


    setState(() {
      isloading = true;
    });

    //show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("ToDo Added brooo..!",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.black),),backgroundColor: Colors.greenAccent.shade200,));

    Navigator.of(context).pop();
    _TASK_ENTERED_IN_TEXTFIELD.clear();



    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }



  Future<void> deletebyId(Welcome data) async {
    // print(data.id);
    await MongoDatabase.delete(data);

    setState(() {
      isloading = true;
    });
    //
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (BuildContext context) => super.widget));
  }

  editbyId(Welcome data) {
    return showDialog(
      context: context,
      builder: (context) {
        return DialogBox_update(
          controller: _TASK_ENTERED_IN_TEXTFIELD,
          onupdate: () => update_on(data.id),
          oncancel: () {
            Navigator.of(context).pop();
            _TASK_ENTERED_IN_TEXTFIELD.clear();
          },
        );
      },
    );
  }

  update_on(var id) async {
    final task = _TASK_ENTERED_IN_TEXTFIELD.text;
    final update_data = Welcome(id: id,task: task);
    await MongoDatabase.update(update_data);



    setState(() {
      isloading = true;
    });
    _TASK_ENTERED_IN_TEXTFIELD.clear();
    Navigator.of(context).pop();



    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => super.widget));
  }
}
