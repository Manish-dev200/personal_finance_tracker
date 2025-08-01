import 'dart:async';
import '../../domain/entity/transaction.dart';
import 'package:uuid/uuid.dart';

import '../models/add_transaction_model.dart';

class TransactionDataSource {
  final List<Transaction> _transactions = [

  ];

  Future<List<Transaction>> fetchTransactions() async {
    await Future.delayed(Duration(seconds: 1));
    return _transactions;
  }

  Future<double> fetchBalance() async {
    await Future.delayed(const Duration(milliseconds: 500));
    double balance = 0;
    for (var t in _transactions) {
      balance += t.type == TransactionType.income ? t.amount : -t.amount;
    }
    return balance;
  }

  Future<AddTransactionModel> addTransaction(Transaction newTransaction) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final tx = newTransaction.copyWith(id: const Uuid().v4());
    _transactions.insert(0, tx); // Insert to keep latest transaction on top
    final updatedBalance = await fetchBalance();
    return AddTransactionModel(
      transaction: tx,
      balance: updatedBalance,
      message: 'Transaction added successfully',
    );
  }
}
