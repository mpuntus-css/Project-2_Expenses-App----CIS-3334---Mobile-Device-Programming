class Expense {
  final String id;
  final double amount;
  final String category;
  final DateTime date;
  final String note;

  Expense({
    this.id = '',
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  factory Expense.fromFirestore(Map<String, dynamic> map, String docId) {
    return Expense(
      id: docId,
      amount: map['amount']?.toDouble() ?? 0,
      category: map['category'] ?? '',
      date: DateTime.parse(map['date']),
      note: map['note'] ?? '',
    );
  }
}
