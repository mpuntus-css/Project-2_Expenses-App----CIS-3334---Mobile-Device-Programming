import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';
import '../widget/expense_item.dart';
import 'add_expense_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  // Map categories to icons (same as in AddExpenseScreen)
  static const Map<String, IconData> categoryIcons = {
    'Food': Icons.restaurant,
    'Housing': Icons.house,
    'Utilities': Icons.lightbulb,
    'Transport': Icons.directions_car,
    'Health': Icons.health_and_safety,
    'Shopping': Icons.shopping_bag,
    'Personal Care': Icons.face_retouching_natural,
    'Entertainment': Icons.movie,
    'Subscriptions': Icons.subscriptions,
    'Education': Icons.school,
    'Gifts': Icons.card_giftcard,
    'Travel': Icons.flight,
    'Others': Icons.category,
  };

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _signOut(context),
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: StreamBuilder<List<Expense>>(
        stream: provider.getExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No expenses found"));
          }

          final expenses = snapshot.data!;

          // Calculate total amount spent
          final totalSpent = expenses.fold<double>(
            0.0,
                (previousValue, element) => previousValue + element.amount,
          );

          return Column(
            children: [
              // ===== Total Spent Box =====
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Spent',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${totalSpent.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ===== List of Expenses =====
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    final icon = categoryIcons[expense.category] ?? Icons.attach_money;

                    return ExpenseItem(
                      icon: icon,
                      expense: expense,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
