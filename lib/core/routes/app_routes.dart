import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finance_tracker/features/transaction/presentation/pages/add_transaction_page.dart';
import '../../features/transaction/presentation/pages/transaction_page.dart';
import 'route_paths.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RoutePaths.transaction,
    routes: [

      GoRoute(
        path: RoutePaths.transaction,
        name: 'transaction',
        builder: (context, state) =>  const TransactionPage(),
      ),

  GoRoute(
        path: RoutePaths.addTransaction,
        name: 'addTransaction',
        builder: (context, state) =>  const AddTransactionPage(),
      ),


    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text(state.error.toString())),
    ),
  );
}
