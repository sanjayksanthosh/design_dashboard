// lib/providers/report_provider.dart
import 'package:flutter/material.dart';
import 'package:hidden_dash_new/models/reportModel.dart';
import 'package:hidden_dash_new/services/report_services.dart';

class ReportProvider with ChangeNotifier {
  final ReportService _reportService = ReportService();
  List<Report> _reports = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchReports({
    required String reportType,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _reports = await _reportService.generateReport(
        reportType: reportType,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
