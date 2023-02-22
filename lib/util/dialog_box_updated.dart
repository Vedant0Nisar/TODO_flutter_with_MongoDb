import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'my_button.dart';

class DialogBox_update extends StatelessWidget {
  final controller;
  final onupdate;
  VoidCallback oncancel;

  DialogBox_update({
    super.key,
    required this.controller,
    required this.onupdate,
    required this.oncancel,
  });

  //TextEditingController dateinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 100,
      content: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Container(
            // height: 306,
            // width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.task, color: Colors.blue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    labelText: "Task",
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyaddButton(
                      text: "Cancel",
                      onPressed: oncancel,
                    ),
                    MyaddButton(
                      text: "Update",
                      onPressed: onupdate,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
