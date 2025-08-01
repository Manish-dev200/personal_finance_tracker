import '../../domain/entity/transaction.dart';
import '../models/add_transaction_model.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> fetchTransactions();
  Future<double> fetchBalance();
  Future<AddTransactionModel> addTransaction(Transaction newTransaction);
}

