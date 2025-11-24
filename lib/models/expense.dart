class Expense {
  final double amount;
  final String category;
  final DateTime date;
  final String note;

  Expense({
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
  });

  // For future use: Convert Expense to a map (useful for Firebase or local storage)
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  // For future use: Create Expense from a map
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      amount: map['amount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
      note: map['note'],
    );
  }
}
