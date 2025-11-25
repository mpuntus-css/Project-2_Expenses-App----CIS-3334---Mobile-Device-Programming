import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  DateTime? selectedDate;
  String? selectedCategory;

  final List<String> categories = [
    'Food',
    'Housing',
    'Utilities',
    'Transport',
    'Health',
    'Shopping',
    'Personal Care',
    'Entertainment',
    'Subscriptions',
    'Education',
    'Gifts',
    'Travel',
    'Others',
  ];

  final Map<String, IconData> categoryIcons = {
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
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (date == null) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()),
    );

    if (time == null) return;

    setState(() {
      selectedDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _saveExpense() async {
    if (!_formKey.currentState!.validate()) return;

    final expense = Expense(
      amount: double.parse(amountController.text),
      category: selectedCategory!,
      note: noteController.text.trim(),
      date: selectedDate ?? DateTime.now(),
    );

    final provider = context.read<ExpenseProvider>();
    await provider.addExpense(expense);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Amount
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: "Amount"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Enter amount";
                    final number = double.tryParse(value);
                    if (number == null || number <= 0) return "Enter a positive number";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Category Dropdown with icons
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(labelText: "Category"),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Row(
                        children: [
                          Icon(categoryIcons[category], color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Text(category),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  validator: (value) =>
                  value == null || value.isEmpty ? "Select category" : null,
                ),
                const SizedBox(height: 16),

                // Note
                TextFormField(
                  controller: noteController,
                  decoration: const InputDecoration(labelText: "Note"),
                ),
                const SizedBox(height: 16),

                // Date Picker
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? "No date selected"
                            : "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2,'0')}-${selectedDate!.day.toString().padLeft(2,'0')} "
                            "${selectedDate!.hour.toString().padLeft(2,'0')}:${selectedDate!.minute.toString().padLeft(2,'0')}",
                      ),
                    ),
                    TextButton(
                      onPressed: _pickDateTime,
                      child: const Text("Select Date & Time"),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Save button
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    onPressed: _saveExpense,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
