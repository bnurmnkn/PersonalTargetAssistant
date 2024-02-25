import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference _todosCollection =
      FirebaseFirestore.instance.collection('todos');

  Future<void> addTodo({
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required String category,
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var docRef = FirebaseFirestore.instance.collection("todos").doc();
      await docRef.set({
        'todoId': docRef.id,
        'userId': currentUser.uid,
        'title': title,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'category': category,
      });
    }
  }

  Future<void> updateTodo({
    required String todoId,
    required String title,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required String category,
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await _todosCollection.doc(todoId).update({
        'title': title,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'category': category,
      });
    }
  }

  Future<void> deleteTodo({
    required String todoId,
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await _todosCollection.doc(todoId).delete();
    }
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getTodos() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return _todosCollection
          .where('userId', isEqualTo: currentUser.uid)
          .snapshots()
          .map((snapshot) => snapshot.docs
              as List<QueryDocumentSnapshot<Map<String, dynamic>>>);
    } else {
      return const Stream<
          List<QueryDocumentSnapshot<Map<String, dynamic>>>>.empty();
    }
  }

  Future<Map<String, dynamic>?> getTodoById({
    required String todoId,
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return (await _todosCollection.doc(todoId).get()).data() as Map<String, dynamic>?;
    } else {
      return null;
    }
  }
}
