/// Represents an expense entry.
class Expense {
  /// Unique identifier for the expense.
  final String id;

  /// The amount of the expense.
  final double amount;

  /// The category of the expense.
  final String category;

  /// The date of the expense.
  final DateTime date;

  /// Additional notes about the expense.
  final String note;

  /// Constructs an [Expense] with the given details.
  Expense({
    this.id = '',
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
  });

  /// Converts the [Expense] to a map for serialization.
  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  /// Creates an [Expense] instance from Firestore data.
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
