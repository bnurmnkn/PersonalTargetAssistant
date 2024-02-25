import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobileprojectbeyzanur/service/firestore-service.dart';

class TodoUpdateCreateWidget extends StatefulWidget {
  final Map<String, dynamic>? todo;
  const TodoUpdateCreateWidget({
    super.key,
    this.todo,
  });

  @override
  State<TodoUpdateCreateWidget> createState() => _TodoUpdateCreateWidgetState();
}

class _TodoUpdateCreateWidgetState extends State<TodoUpdateCreateWidget> {
  late FirestoreService _firestoreService;
  String? todoId;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime startDate;
  late DateTime endDate;
  late TextEditingController categoryController;

  @override
  void initState() {
    super.initState();

    _firestoreService = FirestoreService();
    if (widget.todo != null) {
      todoId = widget.todo!['todoId'];
      titleController =
          TextEditingController(text: widget.todo!['title'] ?? '');
      descriptionController =
          TextEditingController(text: widget.todo!['description'] ?? '');
      startDate = widget.todo!['startDate'].toDate();
      endDate = widget.todo!['endDate'].toDate();
      categoryController =
          TextEditingController(text: widget.todo!['category'] ?? '');
    } else {
      todoId = null;
      titleController = TextEditingController(text: '');
      descriptionController = TextEditingController(text: '');
      startDate = DateTime.now();
      endDate = DateTime.now().add(const Duration(days: 7));
      categoryController = TextEditingController(text: 'Genel');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Görevi Düzenle',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Başlık'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
            const SizedBox(height: 8),
            const Text('Başlangıç Tarihi:'),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null && pickedDate != startDate) {
                        setState(() {
                          startDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                        'Başlangıç: ${DateFormat('yyyy-MM-dd').format(startDate)}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Bitiş Tarihi:'),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: endDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null && pickedDate != endDate) {
                        setState(() {
                          endDate = pickedDate;
                        });
                      }
                    },
                    child: Text(
                        'Bitiş: ${DateFormat('yyyy-MM-dd').format(endDate)}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('İptal'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    // Firestore servisini kullanarak görevi güncelleyin
                    Navigator.of(context).pop();
                    if (todoId == null) {
                      await _firestoreService.addTodo(
                        title: titleController.text,
                        description: descriptionController.text,
                        startDate: startDate,
                        endDate: endDate,
                        category: categoryController.text,
                      );
                    } else {
                      await _firestoreService.updateTodo(
                        todoId: todoId!,
                        title: titleController.text,
                        description: descriptionController.text,
                        startDate: startDate,
                        endDate: endDate,
                        category: categoryController.text,
                      );
                    }
                  },
                  child: const Text('Kaydet'),
                ),
              ],
            ),
          ]),
    );
  }
}
