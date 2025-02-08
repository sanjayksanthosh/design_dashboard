// lib/providers/registration_provider.dart
import 'package:flutter/material.dart';
import 'package:hidden_dash_new/models/registrationModel.dart';
import 'package:hidden_dash_new/services/user_services.dart';

class RegistrationProvider with ChangeNotifier {
  final UserService userService;

  RegistrationProvider({required this.userService});

  RegistrationModel _registrationData = RegistrationModel(
    userId: '',
    fullName: '',
    phoneNumber: '',
    emiratesId: '',
    idExpirationDate: '',
    balance: '',
    remarks: '',
    cardType: 'EID',
    status: 'Active',
    companyName: '',
    storeName: '',
    pickLocation: '',
  );

  String? _errorMessage;

  RegistrationModel get registrationData => _registrationData;
  String? get errorMessage => _errorMessage;

  void updateField(String field, String value) {
    switch (field) {
      case 'userId':
        _registrationData.userId = value;
        break;
      case 'fullName':
        _registrationData.fullName = value;
        break;
      case 'phoneNumber':
        _registrationData.phoneNumber = value;
        break;
      case 'emiratesId':
        _registrationData.emiratesId = value;
        break;
      case 'idExpirationDate':
        _registrationData.idExpirationDate = value;
        break;
      case 'balance':
        _registrationData.balance = value;
        break;
      case 'remarks':
        _registrationData.remarks = value;
        break;
      case 'cardType':
        _registrationData.cardType = value;
        break;
      case 'status':
        _registrationData.status = value;
        break;
      case 'companyName':
        _registrationData.companyName = value;
        break;
      case 'storeName':
        _registrationData.storeName = value;
        break;
      case 'pickLocation':
        _registrationData.pickLocation = value;
        break;
      case 'isOnline':
        _registrationData.isOnline = (value.toLowerCase() == 'true');
        break;
    }
    notifyListeners();
  }

  Future<bool> registerUser() async {
    try {
      _errorMessage = null;
      final success = await userService.registerUser({
        'userId': _registrationData.userId,
        'fullName': _registrationData.fullName,
        'phoneNumber': _registrationData.phoneNumber,
        'emiratesId': _registrationData.emiratesId,
        'idExpirationDate': _registrationData.idExpirationDate,
        'balance': _registrationData.balance,
        'remarks': _registrationData.remarks,
        'cardType': _registrationData.cardType,
        'status': _registrationData.status,
        'companyName': _registrationData.companyName,
        'storeName': _registrationData.storeName,
        'pickLocation': _registrationData.pickLocation,
        'isOnline': _registrationData.isOnline,
      });

      if (success) {
        // Clear form or do some success handling
      }
      return success;
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
      return false;
    }
  }
}
