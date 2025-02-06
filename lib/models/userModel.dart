// models/user_model.dart
class User {
  final String id; // corresponds to _id
  final String userId;
  final String fullName;
  final String emiratesIdNo;
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
  final int? version; // corresponds to __v

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
      id: json['_id'] as String,
      userId: json['userId'] as String,
      fullName: json['fullName'] as String,
      emiratesIdNo: json['emiratesIdNo'] as String,
      cardType: json['cardType'] as String,
      idExpiration: DateTime.parse(json['idExpiration'] as String),
      remarks: json['remarks'] as String?,
      companyName: json['companyName'] as String,
      status: json['status'] as String,
      statusReason: json['statusReason'] as String?,
      storeName: json['storeName'] as String,
      onlineCompany: json['onlineCompany'] as bool,
      balance: (json['balance'] as num).toDouble(),
      rechargeDate: json['rechargeDate'] != null
          ? DateTime.parse(json['rechargeDate'] as String)
          : null,
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      version: json['__v'] as int?,
    );
  }
}
