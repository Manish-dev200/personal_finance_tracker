enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });

  Transaction copyWith({
    String? id,
    String? title,
    double? amount,
    TransactionType? type,
    DateTime? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'Transaction(id: $id, title: $title, amount: $amount, type: $type, date: $date)';
  }
}
