// lib/services/report_service.dart
import 'dart:convert';
import 'package:hidden_dash_new/models/reportModel.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class ReportService {
  final String baseUrl;

  ReportService({this.baseUrl = kApiBaseUrl});

  Future<List<Report>> generateReport({
    required String reportType,
    required DateTime startDate,
    required DateTime endDate,
    String? token,
  }) async {
    final url = Uri.parse('$baseUrl/report/generate');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'reportType': reportType,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> reportsJson = data['data'];
      return reportsJson.map((json) => Report.fromJson(json)).toList();
    } else {
      throw Exception('Failed to generate report');
    }
  }
}
