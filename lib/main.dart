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
// import 'package:socket_io_client/socket_io_client.dart' as IO;




// void main() {
//   // Replace with your Render service URL
//   IO.Socket socket = IO.io(
//     'https://etra-citizen.onrender.com',
//     IO.OptionBuilder()
//         .setTransports(<String>['websocket']) // for Flutter, use websocket transport
//         .enableAutoConnect() // optional
//         .build(),
//   );

//   socket.onConnect((_) {
//     print('Connected to the backend!');
//   });

//   // Listen for an event from the server
//   socket.on('chat message', (data) {
//     print('New chat message: $data');
//   });

//   // Example: emit an event
//   socket.emit('chat message', 'Hello from Flutter!');
// }


void main() {
  // Ensures that the Flutter framework is fully initialized.
 WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// void main() {
//   final socketService = SocketService(
//     serverUrl: 'https://etra-citizen.onrender.com', // Remove the port if using default HTTPS
//   );
  
//   runApp(MyApp(socketService: socketService));
// }
class MyApp extends StatelessWidget {
  // final SocketService socketService;
  final AuthService authService =
      AuthService();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // SocketService provider
        // Provider<SocketService>(
        //   create: (_) => SocketService(serverUrl: 'https://etra-citizen.onrender.com/api'),
        //   dispose: (_, socketService) => socketService.dispose(),
        // ),
     ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(authService: authService),
        ),
        // Other providers
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),

   

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
