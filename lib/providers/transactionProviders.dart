// transaction_provider.dart
import 'package:flutter/material.dart';
import 'package:hidden_dash_new/config.dart';
import 'package:hidden_dash_new/models/transactionModel.dart';
import 'package:hidden_dash_new/services/transaction_services.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String? _error;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final TransactionService _service = TransactionService(baseUrl: kApiBaseUrl);

  Future<void> fetchTransactions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _transactions = await _service.fetchTransactions();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // <-- ADD THE NEW FUNCTION BELOW

  Future<void> fetchTransactionsByUser(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _transactions = await _service.fetchTransactionsByUser(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
