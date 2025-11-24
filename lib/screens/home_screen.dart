import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/expense_item.dart';
import 'add_expense_screen.dart';
import '../models/expense.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> expenses = [
    Expense(amount: 54.20, category: 'Groceries', date: DateTime.now(), note: ''),
    Expense(amount: 18.90, category: 'Uber Ride', date: DateTime.now().subtract(const Duration(days: 1)), note: ''),
    Expense(amount: 75.00, category: 'Electric Bill', date: DateTime.now().subtract(const Duration(days: 2)), note: ''),
    Expense(amount: 32.80, category: 'Restaurant', date: DateTime.now().subtract(const Duration(days: 3)), note: ''),
  ];

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
            tooltip: 'Sign Out',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Spent This Week', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('\$245.90', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Recent Expenses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return ExpenseItem(
                    expense: expense,
                    icon: Icons.shopping_cart, // you can change icon per category later
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
