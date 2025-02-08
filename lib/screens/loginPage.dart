import 'package:flutter/material.dart';
import 'package:hidden_dash_new/providers/authprovider.dart';
import 'package:hidden_dash_new/screens/homescreen.dart';
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

  // Loading state for the login button
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Dark overlay to enhance readability
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: context.width / 2,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 150),
                decoration: BoxDecoration(
                  color: lightBlack.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Company Name at the top
                      Text(
                        'ETRA',
                        style: const TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 36,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Logo or Icon at the top
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.lock,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Heading text
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Subheading text
                      const Text(
                        'Welcome back, please sign in to continue',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // Username Field with prefix icon
                      _buildTextField(
                        'userid',
                        isPassword: false,
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 20),
                      // Password Field with prefix icon and visibility toggle
                      _buildTextField(
                        'Password',
                        isPassword: true,
                        icon: Icons.lock,
                      ),
                      const SizedBox(height: 30),
                      // Login Button with progress indicator while loading
                      ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  // Call the login function from the AuthProvider.
                                  bool success =
                                      await Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .login(_formData);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  if (success) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Login successful!')),
                                    );
                                    // Navigate to your home screen or dashboard here.
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreenNew(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Login failed. Please try again.')),
                                    );
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(context.width / 2, 50),
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.login),
                                  SizedBox(width: 8),
                                  Text(
                                    'Login',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 20),
                      // IconButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => HomeScreenNew(),
                      //         ));
                      //   },
                      //   icon: const Icon(Icons.home),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a text field with an optional prefix icon.
  Widget _buildTextField(String label,
      {bool isPassword = false, IconData? icon}) {
    return TextFormField(controller: TextEditingController(text: isPassword?"Admin@123":"ADMIN001"),
      obscureText: isPassword ? _obscurePassword : false,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
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
        // Save the input using a lower-case key
        _formData[label.toLowerCase()] = value;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
