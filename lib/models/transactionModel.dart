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
    String userId = '';
    String fullName = '';
    if (json['user'] is Map<String, dynamic>) {
      // Convert the nested userId to a string regardless of its original type.
      userId = (json['user']['userId'] ?? '').toString();
      fullName = (json['user']['fullName'] ?? '').toString();
    } else if (json['user'] is String) {
      userId = json['user'];
      fullName = ''; // No fullName provided in this case.
    } else if (json['user'] is int) {
      // In case the API returns the user id as an int.
      userId = json['user'].toString();
      fullName = '';
    }
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
      userId: userId,
      fullName: fullName,
    );
  }
}
