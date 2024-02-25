import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?) onChanged;
  final Function(BuildContext) deleteFunction;
  final Function editFunction;
  final DateTime startDate;
  final DateTime endDate;
  final String category;
  final String taskDescription; 

  const ToDoTile({super.key, 
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
    required this.startDate,
    required this.endDate,
    required this.category,
    required this.taskDescription, 
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskName,
        style: TextStyle(
          decoration: taskCompleted ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Kategori: $category'),
          Text('Başlangıç: ${DateFormat('yyyy-MM-dd').format(startDate)}'),
          Text('Bitiş: ${DateFormat('yyyy-MM-dd').format(endDate)}'),
          Text(
            'Açıklama: $taskDescription',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      leading: Checkbox(
        value: taskCompleted,
        onChanged: onChanged,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: editFunction as void Function()?,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => deleteFunction(context),
          ),
        ],
      ),
    );
  }
}