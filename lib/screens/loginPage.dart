import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hidden_dash_new/providers/userProvider.dart';
import '../../utils/colors.dart';
import '../../utils/media_query_values.dart';
import 'package:hidden_dash_new/screens/header.dart';
import 'package:hidden_dash_new/screens/sidebar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  // Toggle for password visibility
  bool _obscurePassword = true;

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
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            // Username Field
                            _buildTextField('Username', isPassword: false),
                            const SizedBox(height: 10.0),
                            // Password Field
                            _buildTextField('Password', isPassword: true),
                            const SizedBox(height: 20.0),
                            // Login Button
                            ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // Call your login function from the provider
                                  // bool success = await Provider.of<UserProvider>(context, listen: false).login(_formData);
                                  // if (success) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(content: Text('Login successful!')),
                                  //   );
                                  // } else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(content: Text('Login failed.')),
                                  //   );
                                  // }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(context.width / 3, 50),
                                backgroundColor: primaryColor,
                              ),
                              child: const Text('Login'),
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

  /// Builds a text field. If [isPassword] is true, the field will obscure text
  /// and include an icon to toggle password visibility.
  Widget _buildTextField(String label, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        obscureText: isPassword ? _obscurePassword : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: const Color.fromARGB(255, 68, 68, 68).withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          // Add a visibility toggle for password fields
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : null,
        ),
        style: const TextStyle(color: Colors.white),
        onSaved: (value) {
          // Save the input using a lower-case key (e.g., 'username', 'password')
          _formData[label.toLowerCase()] = value;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
