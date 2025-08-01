import '../../data/repositories/transaction_repository.dart';

class FetchBalanceUseCase {
  final TransactionRepository repository;

  FetchBalanceUseCase(this.repository);

  Future<double> call() {
    return repository.fetchBalance();
  }
}
