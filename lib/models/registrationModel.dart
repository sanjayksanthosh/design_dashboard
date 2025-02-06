// models/registration_model.dart
class RegistrationModel {
  String userId;
  String fullName;
  String phoneNumber;
  String emiratesId;
  String idExpirationDate;
  String balance;
  String remarks;
  String cardType;
  String status;
  String companyName;
  String storeName;
  String pickLocation;
  bool isOnline;

  RegistrationModel({
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    required this.emiratesId,
    required this.idExpirationDate,
    required this.balance,
    required this.remarks,
    required this.cardType,
    required this.status,
    required this.companyName,
    required this.storeName,
    required this.pickLocation,
    this.isOnline = false,
  });
}