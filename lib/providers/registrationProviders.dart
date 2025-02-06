// providers/registration_provider.dart
import 'package:flutter/material.dart';
import 'package:hidden_dash_new/models/registrationModel.dart';
import 'package:hidden_dash_new/services/api_services.dart';

class RegistrationProvider with ChangeNotifier {
  final ApiService apiService;

  RegistrationProvider(this.apiService);


void simple(){
  print("object");
}



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
        _registrationData.isOnline = value == 'true';
        break;
    }
    notifyListeners();
  }
 Future<bool> registerUser ({
    required String userId,
    required String fullName,
    required String phoneNumber,
    required String emiratesId,
    required String idExpirationDate,
    required String balance,
    required String remarks,
    required String cardType,
    required String status,
    required String companyName,
    required String storeName,
    required String pickLocation,
    required bool isOnline,
  }) async {
    try {
      print(userId);
      _errorMessage = null; // Reset error message
      await apiService.postRequest('user/register', {
        'userId': userId,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'emiratesId': emiratesId,
        'idExpirationDate': idExpirationDate,
        'balance': balance,
        'remarks': remarks,
        'cardType': cardType,
        'status': status,
        'companyName': companyName,
        'storeName': storeName,
        'pickLocation': pickLocation,
        'isOnline': isOnline,
      });
      return true; // Registration successful
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
      return false; // Registration failed
    }
  }
}