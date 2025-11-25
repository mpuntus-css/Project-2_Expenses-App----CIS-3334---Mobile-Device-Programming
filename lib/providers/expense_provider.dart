import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense.dart';

/// Provides methods to interact with the Firestore database for expenses.
class ExpenseProvider {
  /// Reference to the Firestore collection for expenses.
  final CollectionReference expensesRef =
  FirebaseFirestore.instance.collection("expenses");

  /// Adds a new expense to Firestore.
  Future<void> addExpense(Expense expense) async {
    await expensesRef.add(expense.toMap());
  }

  /// Deletes an expense from Firestore by its [id].
  Future<void> deleteExpense(String id) async {
    await expensesRef.doc(id).delete();
  }


  /// Streams a list of expenses for live updates.
  Stream<List<Expense>> getExpenses() {
    return expensesRef.orderBy('date', descending: true).snapshots().map(
          (snapshot) {
        return snapshot.docs.map((doc) {
          return Expense.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();
      },
    );
  }
}
