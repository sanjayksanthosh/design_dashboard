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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
                        'ECTRA',
                        style: const TextStyle(
                          // Replace with your desired custom font, or remove fontFamily to use the default
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
                      // Login Button with an icon
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            // Call the login function from the AuthProvider.
                            bool success = await Provider.of<AuthProvider>(
                                    context,
                                    listen: false)
                                .login(_formData);
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Login successful!')),
                              );
                              // Navigate to your home screen or dashboard here.
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Login failed. Please try again.')),
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.login),
                        label: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(context.width / 2, 50),
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return HomeScreenNew();
                              },
                            ));
                          },
                          icon: Icon(Icons.home))
                      // Forgot Password text button
                      // TextButton(
                      //   onPressed: () {
                      //     // Navigate to your "Forgot Password" screen if needed
                      //   },
                      //   child: const Text(
                      //     'Forgot Password?',
                      //     style: TextStyle(color: Colors.white70),
                      //   ),
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
  /// If [isPassword] is true, the field will obscure text and include
  /// an icon to toggle password visibility.
  Widget _buildTextField(String label,
      {bool isPassword = false, IconData? icon}) {
    return TextFormField(
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
        // Save the input using a lower-case key (e.g., 'username' or 'password')
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
