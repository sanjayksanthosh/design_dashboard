import 'package:flutter/material.dart';
import 'package:hidden_dash_new/screens/header.dart';
import 'package:hidden_dash_new/screens/sidebar.dart';
import '../../utils/colors.dart'; // Ensure you have your color definitions here
import '../../utils/media_query_values.dart'; // Ensure you have your media query extension here

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String userId = '';
  String fullName = '';
  String phoneNumber = '';
  String emiratesIdNo = '';
  String cardType = 'EID';
  DateTime idExpiration = DateTime.now();
  String remarks = '';
  String status = 'Active';
  String companyName = '';
  String storeName = '';
  String pickLocation = '';
  bool onlineCompany = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Registration Form'),
      //   backgroundColor: primaryColor, // Use your primary color
      // ),
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Header(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: context.width/1.5,
                      padding: EdgeInsets.all(30),
                      transform: Matrix4.translationValues(0, -150, 0),
                      decoration: BoxDecoration(
                        color: lightBlack.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'User  Registration',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              // First Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _buildTextField('User  ID', (value) {
                                      userId = value!;
                                    }, (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your User ID';
                                      }
                                      return null;
                                    }),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildTextField('Full Name', (value) {
                                      fullName = value!;
                                    }, (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your full name';
                                      }
                                      return null;
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              // Second Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _buildTextField('Phone Number', (value) {
                                      phoneNumber = value!;
                                    }, (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your phone number';
                                      }
                                      return null;
                                    }),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildTextField('Emirates ID No', (value) {
                                      emiratesIdNo = value!;
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              // Third Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _buildDropdownField(
                                        'Card Type', ['EID', 'White'], (value) {
                                      cardType = value!;
                                    }),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildDateField('ID Expiration Date',
                                        (value) {
                                      idExpiration = value!;
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              // Fourth Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _buildTextField('Remarks', (value) {
                                      remarks = value!;
                                    }),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildDropdownField(
                                        'Status', ['Active', 'Blocked', 'Frozen'],
                                        (value) {
                                      status = value!;
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              // Fifth Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _buildTextField('Company Name', (value) {
                                      companyName = value!;
                                    }),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _buildTextField('Store Name', (value) {
                                      storeName = value!;
                                    }),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              // Sixth Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _buildTextField('Pick Location', (value) {
                                      pickLocation = value!;
                                    }),
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: onlineCompany,
                                          onChanged: (value) {
                                            setState(() {
                                              onlineCompany = value!;
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Handle form submission
                                        print('Form submitted');
                                      }
                                    },
                                    child: const Text('Register'),
                                    style: ElevatedButton.styleFrom(fixedSize: Size(context.width/3,50),
                                      backgroundColor:
                                          primaryColor, // Use your primary color
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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

  Widget _buildTextField(String label, Function(String?) onSaved,
      [String? Function(String?)? validator]) {
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
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }

  Widget _buildDropdownField(
      String label, List<String> items, Function(String?) onChanged) {
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
        style: const TextStyle(color: Colors.white),
        dropdownColor: lightBlack,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDateField(String label, Function(DateTime?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: idExpiration,
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            setState(() {
              idExpiration = pickedDate;
            });
            onChanged(pickedDate);
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Colors.white),
              filled: true,
              fillColor: lightBlack.withOpacity(0.7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(color: Colors.white),
            controller: TextEditingController(),
          ),
        ),
      ),
    );
  }
}
