import '../../domain/entity/transaction.dart';

class AddTransactionModel {
  final String message;
  final Transaction transaction;
  final double balance;

  AddTransactionModel({
    required this.message,
    required this.transaction,
    required this.balance,
  });
}
