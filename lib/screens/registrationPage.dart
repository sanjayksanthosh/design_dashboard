import 'package:flutter/material.dart';
import 'package:hidden_dash_new/providers/userProvider.dart';
import 'package:provider/provider.dart';
import '../../utils/colors.dart';
import '../../utils/media_query_values.dart';
import 'package:hidden_dash_new/screens/header.dart';
import 'package:hidden_dash_new/screens/sidebar.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool isOnlineCompany = false;
  final Map<String, dynamic> _formData = {};

  // Mapping of display labels to API field keys
  final Map<String, String> fieldKeys = {
    "User ID": "userId",
    "Full Name": "fullName",
    "Emirates ID No": "emiratesIdNo",
    "Card Type": "cardType",
    "ID Expiration Date": "idExpiration",
    "Remarks": "remarks",
    "Company Name": "companyName",
    "Status": "status",
    "Store Name": "storeName",
  };

  // Controller for the date picker field
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SideBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Header(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: context.width / 1.5,
                      padding: const EdgeInsets.all(30),
                      transform: Matrix4.translationValues(0, -120, 0),
                      decoration: BoxDecoration(
                        color: lightBlack.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'User Registration',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            // Row 1: User ID & Full Name
                            Row(
                              children: [
                                Expanded(child: _buildTextField('Full Name')),
                                const SizedBox(width: 10),

                                Expanded(child: _buildTextField('Emirates ID No')),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            // Row 2: Emirates ID No & Card Type
                            Row(
                              children: [
                                Expanded(child: _buildDropdownField('Card Type', ['EID', 'White'])),

                                const SizedBox(width: 10),

                                Expanded(child: _buildDateField('ID Expiration Date')),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            // Row 3: ID Expiration Date (with date picker) & Status
                            Row(
                              children: [

                                Expanded(child: _buildDropdownField('Status', ['Active', 'Blocked', 'Frozen'])),
                                const SizedBox(width: 10),

                                Expanded(child: _buildTextField('Remarks', isOptional: true)),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            // Row 4: Remarks (optional) & Company Name
                            Row(
                              children: [
                                Expanded(child: _buildTextField('Company Name')),

                                const SizedBox(width: 10),
                                Expanded(child: _buildTextField('Store Name')),

                              ],
                            ),
                            const SizedBox(height: 10.0),
                            // Row 5: Store Name & Online Company checkbox
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: isOnlineCompany,
                                        onChanged: (value) {
                                          setState(() {
                                            isOnlineCompany = value!;
                                            _formData['onlineCompany'] = value;
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Online Company',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            // Register Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      print("_formData: $_formData");
                                      bool success = await Provider.of<UserProvider>(context, listen: false)
                                          .registerUser(_formData);
                                      if (success) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('User registered successfully!')),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('User registration failed.')),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text('Register'),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(context.width / 3, 50),
                                    backgroundColor: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a text field. For fields like 'Remarks', validation is optional.
  Widget _buildTextField(String label, {bool isOptional = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: const Color.fromARGB(255, 68, 68, 68).withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
        onSaved: (value) {
          // Save using the API field key from our mapping.
          String key = fieldKeys[label] ?? label;
          _formData[key] = value;
        },
        validator: (value) {
          if (!isOptional && (value == null || value.isEmpty)) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  /// Builds a dropdown field.
  Widget _buildDropdownField(String label, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: const Color.fromARGB(255, 68, 68, 68).withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        dropdownColor: const Color.fromARGB(255, 68, 68, 68),
        style: const TextStyle(color: Colors.white),
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            String key = fieldKeys[label] ?? label;
            _formData[key] = value;
          });
        },
        onSaved: (value) {
          String key = fieldKeys[label] ?? label;
          _formData[key] = value;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }

  /// Builds a text field that triggers a date picker.
  Widget _buildDateField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: _dateController,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: const Color.fromARGB(255, 68, 68, 68).withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.calendar_today, color: Colors.white),
        ),
        readOnly: true,
        style: const TextStyle(color: Colors.white),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            // Format the date as ISO8601 (e.g. 2026-08-15T00:00:00.000Z)
            String formattedDate = pickedDate.toUtc().toIso8601String();
            _dateController.text = formattedDate;
            String key = fieldKeys[label] ?? label;
            _formData[key] = formattedDate;
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select $label';
          }
          return null;
        },
      ),
    );
  }
}
