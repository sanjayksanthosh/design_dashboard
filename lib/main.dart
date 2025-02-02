import 'package:flutter/material.dart';
import 'package:hidden_dash_new/dashboardtest.dart';
import 'package:hidden_dash_new/screens/LogHistoryPage.dart';
import 'package:hidden_dash_new/screens/homescreen.dart';
import 'package:hidden_dash_new/screens/new_reportPage.dart';
import 'package:hidden_dash_new/screens/rechargePage.dart';
import 'package:hidden_dash_new/screens/registrationPage.dart';
import 'package:hidden_dash_new/screens/reportPage.dart';
import 'package:hidden_dash_new/screens/searchUserPage.dart';

import 'utils/colors.dart';
// import 'view/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Dashboard Template UI',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: darkBlack,
      ),
      // home: RegistrationForm(),
      home: HomeScreenNew(),
    );
  }
}
