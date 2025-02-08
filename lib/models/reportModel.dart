// lib/models/report_model.dart
class Report {
  final String id;
  final String transactionId;
  final int amount;
  final int balanceAfter;
  final DateTime date;
  final String description;
  final String type;
  final String? refundId;
  final String? userId;
  final String? fullName;

  Report({
    required this.id,
    required this.transactionId,
    required this.amount,
    required this.balanceAfter,
    required this.date,
    required this.description,
    required this.type,
    this.refundId,
    this.userId,
    this.fullName,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};
    return Report(
      id: json['_id'] ?? '',
      transactionId: json['transactionId'] ?? '',
      amount: json['amount'] ?? 0,
      balanceAfter: json['balanceAfter'] ?? 0,
      date: DateTime.parse(json['date']),
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      refundId: json['refundId'],
      userId: user['userId'],
      fullName: user['fullName'],
    );
  }
}
