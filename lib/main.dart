import 'package:flutter/material.dart';
import 'package:hidden_dash_new/config.dart';
import 'package:hidden_dash_new/providers/authprovider.dart';
import 'package:hidden_dash_new/providers/registrationProviders.dart';
import 'package:hidden_dash_new/providers/reportProvider.dart';
import 'package:hidden_dash_new/providers/transactionProviders.dart';
import 'package:hidden_dash_new/providers/userProvider.dart';
import 'package:hidden_dash_new/screens/loginPage.dart';
import 'package:hidden_dash_new/screens/registrationPage.dart';
import 'package:hidden_dash_new/services/auth_services.dart';
import 'package:hidden_dash_new/services/socket_services.dart';
import 'package:hidden_dash_new/services/user_services.dart';
import 'package:provider/provider.dart';
import 'screens/homescreen.dart'; // Import your HomeScreen widget
import 'utils/colors.dart';

void main() {
  final socketService = SocketService();
  runApp(MyApp(socketService: socketService));
}

class MyApp extends StatelessWidget {
  final SocketService socketService;
  final AuthService authService =
      AuthService(baseUrl: 'https://etra-citizen.onrender.com/api');

  MyApp({super.key,required this.socketService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // SocketService provider
        Provider<SocketService>(
          create: (_) => SocketService(),
          dispose: (_, socketService) => socketService.dispose(),
        ),

        // Other providers
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),

        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(authService: authService),
        ),

        ChangeNotifierProvider(
          create: (context) => UserProvider(UserService(baseUrl: kApiBaseUrl)
            
          ),
        ),

        // If you need RegistrationProvider, you can add it here:
        // ChangeNotifierProvider(create: (_) => RegistrationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Etra',
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: darkBlack,
        ),
        // Instead of always showing the LoginPage,
        // we use an AuthWrapper to decide which screen to show.
        home: AuthWrapper(),
      ),
    );
  }
}

/// AuthWrapper checks the authentication state and returns
/// the HomeScreen if the user is authenticated (i.e. a valid token exists)
/// or the LoginPage if the user is not authenticated.
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        // When the provider determines the user is authenticated, show HomeScreen.
        if (authProvider.isAuthenticated) {
          // If your home screen widget is named HomeScreenNew, use that.
          // Otherwise, adjust accordingly.
          return HomeScreenNew();
        } else {
          // Otherwise, show the login screen.
          return LoginPage();
        }
      },
    );
  }
}
