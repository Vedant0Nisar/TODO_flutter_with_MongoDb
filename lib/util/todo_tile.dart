import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  // TextStyle _textStyle = TextStyle(decoration: TextDecoration.none);
  final String taskName;
  final bool taskCompleted;
  final  update_data_of_Condition;
  Function(bool?)? onChanged;
  Function(BuildContext?)? deleteFunction;
  Function(BuildContext?)? editfunction;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    this.update_data_of_Condition,
    this.onChanged,
    this.deleteFunction,
    this.editfunction
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: editfunction,
              icon: Icons.edit,
              backgroundColor: Colors.green.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(


          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(children: [
            Checkbox(
              value: taskCompleted,
              onChanged: onChanged,
              activeColor: Colors.purple.shade500,


            ),
            Text
              (taskName,
              style: TextStyle(
                decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}












