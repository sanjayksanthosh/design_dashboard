import 'package:flutter/material.dart';
import 'package:hidden_dash_new/providers/authprovider.dart';
import 'package:hidden_dash_new/providers/registrationProviders.dart';
import 'package:hidden_dash_new/providers/transactionProviders.dart';
import 'package:hidden_dash_new/providers/userProvider.dart';
import 'package:hidden_dash_new/screens/loginPage.dart';
import 'package:hidden_dash_new/screens/registrationPage.dart';
import 'package:hidden_dash_new/services/api_services.dart';
import 'package:hidden_dash_new/services/auth_services.dart';
import 'package:hidden_dash_new/services/user_services.dart';
import 'package:provider/provider.dart';
import 'screens/homescreen.dart'; // Import your HomeScreen
import 'utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthService authService =
      AuthService(baseUrl: 'https://etra-citizen.onrender.com');
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),

        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(authService: authService),
        ),

        ChangeNotifierProvider(
            create: (context) => UserProvider(UserService(
                'https://etra-citizen.onrender.com/api'))), // Add UserProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Etra',
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: darkBlack,
        ),
        home: LoginPage(), // Your main screen
      ),
    );
  }
}
