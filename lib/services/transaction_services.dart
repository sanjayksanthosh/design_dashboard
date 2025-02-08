// lib/services/transaction_service.dart
import 'dart:convert';
import 'package:hidden_dash_new/models/transactionModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class TransactionService {
  final String baseUrl;

  TransactionService({this.baseUrl = kApiBaseUrl});

  Future<List<Transaction>> fetchTransactions() async {
                final prefs = await SharedPreferences.getInstance();
        String? token=await prefs.getString('accessToken');
    final url = Uri.parse('$kApiBaseUrl/transaction/getall');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.get(url, headers: headers);
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

  Future<List<Transaction>> fetchTransactionsByUser(String userId) async {
                final prefs = await SharedPreferences.getInstance();
        String? token=await prefs.getString('accessToken');
    final url = Uri.parse('$kApiBaseUrl/transaction/byuser');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({'userId': userId}),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is List) {
          return jsonData.map((item) => Transaction.fromJson(item)).toList();
        } else {
          throw Exception("Unexpected JSON format: ${response.body}");
        }
      } else {
        throw Exception('Failed to fetch transactions by user: ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      print("Error fetching transactions by user: $error");
      print("Stacktrace: $stackTrace");
      throw Exception("Error fetching transactions by user: $error");
    }
  }
}
