// transaction_model.dart
class Transaction {
  final String id;
  final String transactionId;
  final int amount;
  final int balanceAfter;
  final DateTime date;
  final String description;
  final String type;
  final String userId;
  final String fullName;

  Transaction({
    required this.id,
    required this.transactionId,
    required this.amount,
    required this.balanceAfter,
    required this.date,
    required this.description,
    required this.type,
    required this.userId,
    required this.fullName,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'] ?? '',
      transactionId: json['transactionId'] ?? '',
      amount: json['amount'] is int
          ? json['amount']
          : int.tryParse(json['amount'].toString()) ?? 0,
      balanceAfter: json['balanceAfter'] is int
          ? json['balanceAfter']
          : int.tryParse(json['balanceAfter'].toString()) ?? 0,
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      userId: json['user'] != null ? (json['user']['userId'] ?? '') : '',
      fullName: json['user'] != null ? (json['user']['fullName'] ?? '') : '',
    );
  }
}
