import '../../data/models/add_transaction_model.dart';
import '../../data/repositories/transaction_repository.dart';
import '../entity/transaction.dart';


class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  Future<AddTransactionModel> call(Transaction transaction) {
    return repository.addTransaction(transaction);
  }
}
