import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/transaction_data_source.dart';
import '../../data/repositories/transaction_repository.dart';
import '../../domain/usecases/add_transaction_usecase.dart';
import '../../domain/usecases/fetch_balance_usecase.dart';
import '../../domain/usecases/fetch_transactions_usecase.dart';

import '../../presentation/notifier/transaction_notifier.dart';
import '../repositories/transaction_repository_impl.dart';

// Data Source
final transactionRemoteDataSourceProvider = Provider<TransactionDataSource>(
      (ref) => TransactionDataSource(),
);

// Repository
final transactionRepositoryProvider = Provider<TransactionRepository>(
      (ref) => TransactionRepositoryImpl(ref.watch(transactionRemoteDataSourceProvider)),
);

// Use Cases
final fetchTransactionsUseCaseProvider = Provider<FetchTransactionsUseCase>(
      (ref) => FetchTransactionsUseCase(ref.watch(transactionRepositoryProvider)),
);

final fetchBalanceUseCaseProvider = Provider<FetchBalanceUseCase>(
      (ref) => FetchBalanceUseCase(ref.watch(transactionRepositoryProvider)),
);

final addTransactionUseCaseProvider = Provider<AddTransactionUseCase>(
      (ref) => AddTransactionUseCase(ref.watch(transactionRepositoryProvider)),
);

// Notifier
final transactionNotifierProvider =
StateNotifierProvider<TransactionNotifier, TransactionState>(
      (ref) => TransactionNotifier(
    fetchTransactionsUseCase: ref.watch(fetchTransactionsUseCaseProvider),
    fetchBalanceUseCase: ref.watch(fetchBalanceUseCaseProvider),
    addTransactionUseCase: ref.watch(addTransactionUseCaseProvider),
  ),
);
