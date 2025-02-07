// transaction_service.dart
import 'dart:convert';
import 'package:hidden_dash_new/models/transactionModel.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static const String apiUrl =
      'https://etra-citizen.onrender.com/api/transaction/getall';

  Future<List<Transaction>> fetchTransactions() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return jsonData.map((item) => Transaction.fromJson(item)).toList();
        } else {
          throw Exception("Unexpected JSON format: ${response.body}");
        }
      } else {
        throw Exception('Failed to fetch transactions: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      print("Error fetching transactions: $error");
      print("Stacktrace: $stackTrace");
      throw Exception("Error fetching transactions: $error");
    }
  }
}
