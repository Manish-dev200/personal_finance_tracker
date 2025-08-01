import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_paths.dart';
import '../../../../core/widgets/app_text.dart';
import '../../domain/entity/transaction.dart';
import '../../domain/provider/transaction_provider.dart';

class TransactionPage extends ConsumerWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionNotifierProvider);
    final notifier = ref.read(transactionNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const AppText(
          'Transaction',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async => notifier.loadInitialData(),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.error != null
            ? Center(
          child: AppText(
            state.error!,
            style: const TextStyle(color: Colors.red),
          ),
        )
            : Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const AppText(
                    'Account Balance',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    '₹ ${state.balance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            if(state.transactions.isNotEmpty)...{
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = state.transactions[index];
                    return _TransactionTile(transaction: transaction);
                  },
                ),
              ),
            }else...{
              const Padding(
                padding:EdgeInsets.only(left: 16,right: 16,top: 50),
                child: Column(
                  children: [
                    AppText(
                      'No Transactions Found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    AppText(
                      'You can start with the add button to create your transactions.',
                      textAlign:TextAlign.center,

                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ) ,
              )


            }

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutePaths.addTransaction);

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Transaction transaction;

  const _TransactionTile({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    return Card(
      child: ListTile(
        title: AppText(
          transaction.title,
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: AppText(
          _formatDate(transaction.date),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: AppText(
          '${isIncome ? '+ ₹' : '- ₹'}${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isIncome ? Colors.green : Colors.red,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
