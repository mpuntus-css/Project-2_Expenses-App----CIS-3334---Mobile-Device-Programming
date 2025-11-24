import 'package:flutter/material.dart';
import '../models/expense.dart';


// Expense Item
class ExpenseItem extends StatelessWidget {

  final IconData icon;
  final Expense expense;


  const ExpenseItem({super.key, required this.icon, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: Icon(icon, size: 26),
        ),
        title: Text(expense.category,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        subtitle: Text(expense.date.toString()),
        trailing: Text('\$${expense.amount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}