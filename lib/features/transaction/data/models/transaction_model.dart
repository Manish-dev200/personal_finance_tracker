// lib/features/transaction/data/models/transaction_model.dart


import '../../domain/entity/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.title,
    required super.amount,
    required super.type,
    required super.date,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      type: TransactionType.values.firstWhere((e) => e.name == map['type']),
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'type': type.name,
      'date': date.toIso8601String(),
    };
  }
}
