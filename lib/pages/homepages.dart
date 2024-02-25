import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobileprojectbeyzanur/pages/todo-update-create.dart';
import 'package:mobileprojectbeyzanur/service/firestore-service.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirestoreService _firestoreService;
  String? category;

  @override
  void initState() {
    _firestoreService = FirestoreService();
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // TODO: Firestore servisi kullanarak durumu güncelleyin
      // _firestoreService.updateTodo(
      //   todoId: documents[index].id,
      //   title: todoData['title'] ?? '',
      //   description: todoData['description'] ?? '',
      //   startDate: todoData['startDate'].toDate(),
      //   endDate: todoData['endDate'].toDate(),
      //   category: todoData['category'] ?? '',
      // );
    }
  }

  void deleteTask(String todoId) async {
    await _firestoreService.deleteTodo(todoId: todoId);
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => const Dialog(child: TodoUpdateCreateWidget()),
    );
  }

  void editTask(String todoId) {
    _firestoreService.getTodoById(todoId: todoId).then((todo) => {
          if (todo != null)
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(child: TodoUpdateCreateWidget(todo: todo));
              },
            ),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('HEDEFLERİM'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        stream: _firestoreService.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                snapshot.data ?? [];
            if (category != null && category != '') {
              documents = documents
                  .where((element) => element.data()['category'] == category)
                  .toList();
            }

            List<dynamic> categories = (snapshot.data ?? [])
                .map((e) => e.data()['category'] ?? '')
                .toSet()
                .toList();

            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (categories.length > 1)
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FilterChip(
                            selected: category == categories[index],
                            label: Text(categories[index]),
                            onSelected: (value) {
                              setState(() {
                                category = categories[index] == category
                                    ? null
                                    : categories[index];
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> todoData = documents[index].data();

                      return ToDoTile(
                        taskName: todoData['title'] ?? '',
                        taskCompleted: false,
                        onChanged: (value) => checkBoxChanged(value, index),
                        deleteFunction: (context) =>
                            deleteTask(documents[index]['todoId']),
                        editFunction: () =>
                            editTask(documents[index]['todoId']),
                        startDate: todoData['startDate'].toDate(),
                        endDate: todoData['endDate'].toDate(),
                        category: todoData['category'] ?? '',
                        taskDescription: todoData['description'] ?? '',
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
