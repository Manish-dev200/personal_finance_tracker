import '../../data/datasources/transaction_data_source.dart';
import '../../data/models/add_transaction_model.dart';
import '../../data/repositories/transaction_repository.dart';
import '../../domain/entity/transaction.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDataSource dataSource;

  TransactionRepositoryImpl(this.dataSource);

  @override
  Future<List<Transaction>> fetchTransactions() {
    return dataSource.fetchTransactions();
  }

  @override
  Future<double> fetchBalance() {
    return dataSource.fetchBalance();
  }

  @override
  Future<AddTransactionModel> addTransaction(Transaction newTransaction) {
    return dataSource.addTransaction(newTransaction);
  }
}
