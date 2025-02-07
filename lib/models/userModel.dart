// models/user_model.dart
class User {
  final String id;
  final String userId;
  final String fullName;
  final String emiratesIdNo; // remains non-nullable
  final String cardType;
  final DateTime idExpiration;
  final String? remarks;
  final String companyName;
  String status;
  final String? statusReason;
  final String storeName;
  final bool onlineCompany;
  final double balance;
  final DateTime? rechargeDate;
  final DateTime? expiryDate;
  final DateTime createdAt;
  final int? version;

  User({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.emiratesIdNo,
    required this.cardType,
    required this.idExpiration,
    this.remarks,
    required this.companyName,
    required this.status,
    this.statusReason,
    required this.storeName,
    required this.onlineCompany,
    required this.balance,
    this.rechargeDate,
    this.expiryDate,
    required this.createdAt,
    this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      emiratesIdNo: json['emiratesIdNo'] as String? ?? 'N/A', // default value
      cardType: json['cardType'] as String? ?? 'N/A',
      idExpiration: json['idExpiration'] != null
          ? DateTime.parse(json['idExpiration'] as String)
          : DateTime.now(),
      remarks: json['remarks'] as String?,
      companyName: json['companyName'] as String? ?? 'N/A',
      status: json['status'] as String? ?? 'N/A',
      statusReason: json['statusReason'] as String?,
      storeName: json['storeName'] as String? ?? 'N/A',
      onlineCompany: json['onlineCompany'] as bool? ?? false,
      balance: json['balance'] != null ? (json['balance'] as num).toDouble() : 0.0,
      rechargeDate: json['rechargeDate'] != null
          ? DateTime.parse(json['rechargeDate'] as String)
          : null,
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      version: json['__v'] as int?,
    );
  }
}
