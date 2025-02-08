import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hidden_dash_new/providers/authprovider.dart';
import 'package:hidden_dash_new/screens/LogHistoryPage.dart';
import 'package:hidden_dash_new/screens/homescreen.dart';
import 'package:hidden_dash_new/screens/profilePage.dart';
import 'package:hidden_dash_new/screens/rechargePage.dart';
import 'package:hidden_dash_new/screens/registrationPage.dart';
import 'package:hidden_dash_new/screens/reportPage.dart';
import 'package:hidden_dash_new/screens/searchUserPage.dart';
import 'package:hidden_dash_new/screens/loginPage.dart';
import 'package:hidden_dash_new/utils/colors.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final List<IconData> _icons = [
    Icons.home,
    Icons.group_add_outlined,
    Icons.history,
    Icons.person,
    Icons.bar_chart,
    Icons.credit_card,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.06,
      height: context.height,
      color: darkBlack,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            // Top circle avatar placeholder
            Container(
              width: context.width * 0.05,
              height: context.height * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4.0, color: primaryColor),
              ),
            ),
            const SizedBox(height: 20.0),
            // List of navigation icons
            ..._icons
                .map(
                  (icon) => _customIcon(icon, _icons.indexOf(icon)),
                )
                .toList(),
            // Spacer pushes the logout button to the bottom
            const Spacer(),
            // Logout Icon Button with confirmation dialog
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: IconButton(
                onPressed: () async {
                  // Show a confirmation dialog before logging out.
                  bool? confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    // Call the logout function from AuthProvider.
                    bool isLogut =
                        await Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                    // Navigate to the LoginPage (using pushReplacement to remove previous routes).
                    if (isLogut) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    } else {
                      print("failed");
                    }
                  }
                },
                icon: const Icon(Icons.logout, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom icon button for navigation
  Padding _customIcon(IconData icon, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: IconButton(
        onPressed: () {
          // Navigate to different pages based on the index
          switch (index) {
            case 0:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreenNew()));
              break;
            case 1:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()));
              break;
            case 2:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoryPage()));
              break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserSearchPage()));
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReportPage()));
              break;
            case 5:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RechargePage()));
              break;
            default:
              break;
          }
        },
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}
