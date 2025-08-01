import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/transaction.dart';
import '../../domain/usecases/add_transaction_usecase.dart';
import '../../domain/usecases/fetch_balance_usecase.dart';
import '../../domain/usecases/fetch_transactions_usecase.dart';


class TransactionState {
  final bool isLoading;
  final List<Transaction> transactions;
  final double balance;
  final String? error;

  TransactionState({
    required this.isLoading,
    required this.transactions,
    required this.balance,
    this.error,
  });

  factory TransactionState.initial() {
    return TransactionState(
      isLoading: false,
      transactions: [],
      balance: 0.0,
      error: null,
    );
  }

  TransactionState copyWith({
    bool? isLoading,
    List<Transaction>? transactions,
    double? balance,
    String? error,
  }) {
    return TransactionState(
      isLoading: isLoading ?? this.isLoading,
      transactions: transactions ?? this.transactions,
      balance: balance ?? this.balance,
      error: error,
    );
  }
}



class TransactionNotifier extends StateNotifier<TransactionState> {
  final FetchTransactionsUseCase fetchTransactionsUseCase;
  final FetchBalanceUseCase fetchBalanceUseCase;
  final AddTransactionUseCase addTransactionUseCase;

  TransactionNotifier({
    required this.fetchTransactionsUseCase,
    required this.fetchBalanceUseCase,
    required this.addTransactionUseCase,
  }) : super(TransactionState.initial()) {
    loadInitialData();
  }



  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true);
    try {
      final transactions = await fetchTransactionsUseCase();
      final balance = await fetchBalanceUseCase();
      state = state.copyWith(
        isLoading: false,
        transactions: transactions,
        balance: balance,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await addTransactionUseCase(transaction);
      final updatedList = {result.transaction, ...state.transactions}.toList();
      state = state.copyWith(
        transactions: updatedList,
        balance: result.balance,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
