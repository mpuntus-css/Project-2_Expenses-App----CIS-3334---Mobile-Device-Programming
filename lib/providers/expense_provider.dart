import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense.dart';

class ExpenseProvider {
  final CollectionReference expensesRef =
  FirebaseFirestore.instance.collection("expenses");

  // Add expense to Firestore
  Future<void> addExpense(Expense expense) async {
    await expensesRef.add(expense.toMap());
  }

  Future<void> deleteExpense(String id) async {
    await expensesRef.doc(id).delete();
  }


  // Stream of expenses for live updates
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
