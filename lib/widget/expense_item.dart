import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final IconData icon;

  const ExpenseItem({
    super.key,
    required this.expense,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context, listen: false);

    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(expense.category),
        subtitle: Text("\$${expense.amount.toStringAsFixed(2)}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            final shouldDelete = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete Expense"),
                content: const Text("Are you sure you want to delete this expense?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text("Delete"),
                  ),
                ],
              ),
            );

            if (shouldDelete == true) {
              await provider.deleteExpense(expense.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Expense deleted")),
              );
            }
          },
        ),
        onTap: () {
          final formattedDate =
              "${expense.date.year}-${expense.date.month.toString().padLeft(2,'0')}-${expense.date.day.toString().padLeft(2,'0')} "
              "${expense.date.hour.toString().padLeft(2,'0')}:${expense.date.minute.toString().padLeft(2,'0')}";

          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Expense Details"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Category: ${expense.category}"),
                  Text("Amount: \$${expense.amount.toStringAsFixed(2)}"),
                  Text("Note: ${expense.note.isNotEmpty ? expense.note : 'No note'}"),
                  Text("Date: $formattedDate"), // shows without seconds
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
