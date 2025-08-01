import '../../data/repositories/transaction_repository.dart';
import '../entity/transaction.dart';

class FetchTransactionsUseCase {
  final TransactionRepository repository;

  FetchTransactionsUseCase(this.repository);

  Future<List<Transaction>> call() {
    return repository.fetchTransactions();
  }
}
