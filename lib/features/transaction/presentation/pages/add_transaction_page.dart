import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';

import '../../../../core/widgets/app_text_field.dart';
import '../../domain/entity/transaction.dart';
import '../../domain/provider/transaction_provider.dart';


class AddTransactionPage extends ConsumerStatefulWidget {
  const AddTransactionPage({super.key});

  @override
  ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String? selectedType = 'Income';

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final title = _titleController.text.trim();
      final amount = double.tryParse(_amountController.text.trim()) ?? 0;

      final newTransaction = Transaction(
        id: '',
        title: title,
        amount: amount,
        type: selectedType == 'Income' ? TransactionType.income : TransactionType.expense,
        date: DateTime.now(),
      );

      ref.read(transactionNotifierProvider.notifier).addTransaction(newTransaction).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction added successfully')),
        );
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(transactionNotifierProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AbsorbPointer(
          absorbing: isLoading,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                AppTextField(
                  title: 'Transaction Title',
                  controller: _titleController,
                  hint: 'e.g. Salary, Rent',
                  validator: (value) =>  _titleController.text.trim().isEmpty ? 'Title is required' : null,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  title: 'Amount',
                  controller: _amountController,
                  hint: 'e.g. 1500',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_amountController.text.trim().isEmpty) return 'Amount is required';
                    final val = double.tryParse(_amountController.text);
                    if (val == null || val <= 0) return 'Enter valid amount';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppDropdown(
                  title: 'Type',
                  hint: 'Select Type',
                  value: selectedType,
                  items: const ['Income', 'Expense'],
                  onChanged: (val) => setState(() => selectedType = val),
                ),
                const SizedBox(height: 24),
                AppButton(
                  isLoading ? 'Adding...' : 'Add Transaction',
                  onTap: isLoading ? null : _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
