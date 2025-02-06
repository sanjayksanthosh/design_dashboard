import 'package:flutter/material.dart';
import 'package:hidden_dash_new/screens/LogHistoryPage.dart';
import 'package:hidden_dash_new/screens/homescreen.dart';
import 'package:hidden_dash_new/screens/profilePage.dart';
import 'package:hidden_dash_new/screens/rechargePage.dart';
import 'package:hidden_dash_new/screens/registrationPage.dart';
import 'package:hidden_dash_new/screens/reportPage.dart';
import 'package:hidden_dash_new/screens/searchUserPage.dart';
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
            Container(
              width: context.width * 0.05,
              height: context.height * 0.05,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4.0, color: primaryColor),
              ),
            ),
            // SizedBox(
            //   height: context.height *0.05,
            // ),
            ..._icons
                .map(
                  (icon) => _customIcon(
                    icon,
                    _icons.indexOf(icon),
                  ),
                )
                .toList(),
            SizedBox(
              height: context.height * 0.02,
            ),
            // Container(
            //   width: context.width * 0.03,
            //   height: context.height * 0.06,
            //   decoration: BoxDecoration(
            //     color: chocolateMelange,
            //     borderRadius: BorderRadius.circular(12.0),
            //   ),
            //   child: const Icon(
            //     Icons.data_exploration_rounded,
            //     color: primaryColor,
            //     size: 20.0,
            //   ),
            // ),
            // SizedBox(
            //   height: context.height * 0.015,
            // ),
            // Container(
            //   width: context.width * 0.03,
            //   height: context.height * 0.06,
            //   decoration: BoxDecoration(
            //     color: lightBlack,
            //     borderRadius: BorderRadius.circular(12.0),
            //   ),
            //   child: const Icon(
            //     Icons.account_balance,
            //     color: royalFuchsia,
            //     size: 20.0,
            //   ),
            // ),
            // SizedBox(
            //   height: context.height * 0.015,
            // ),
            // Container(
            //   width: context.width * 0.03,
            //   height: context.height * 0.06,
            //   decoration: BoxDecoration(
            //     color: lightBlack,
            //     borderRadius: BorderRadius.circular(12.0),
            //   ),
            //   child: const Icon(
            //     Icons.account_tree,
            //     color: promiscuousPink,
            //     size: 20.0,
            //   ),
            // ),
            // SizedBox(
            //   height: context.height * 0.015,
            // ),
            // Container(
            //   width: context.width * 0.03,
            //   height: context.height * 0.06,
            //   decoration: BoxDecoration(
            //     color: lightBlack,
            //     borderRadius: BorderRadius.circular(12.0),
            //   ),
            //   child: Icon(
            //     Icons.add,
            //     color: darkGrey.withOpacity(0.6),
            //     size: 20.0,
            //   ),
            // ),
            // const Spacer(),
            // Container(
            //   width: context.width * 0.03,
            //   height: context.height * 0.06,
            //   decoration: BoxDecoration(
            //     color: lightBlack,
            //     borderRadius: BorderRadius.circular(12.0),
            //   ),
            //   child: Icon(
            //     Icons.logout,
            //     color: darkGrey.withOpacity(0.6),
            //     size: 20.0,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

 Padding _customIcon(IconData icon, int index) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: IconButton(
      onPressed: () {
        // Navigate to different pages based on the index
        switch (index) {
          case 0:
            // Navigate to Dashboard
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeScreenNew(); // Replace with your actual dashboard page
            }));
            break;
          case 1:
            // Navigate to Messages
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RegistrationPage(); // Replace with your actual messages page
            }));
            break;
          case 2:
            // Navigate to Statistics
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HistoryPage(); // Replace with your actual statistics page
            }));
            break;
          case 3:
            // Navigate to Wallet
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return UserSearchPage(); // Replace with your actual wallet page
            }));
            break;
          case 4:
            // Navigate to Messages
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ReportPage(); // Replace with your actual messages page
            }));
            break;
          case 5:
            // Navigate to Profile
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RechargePage(); // Replace with your actual profile page
            }));
            break;
          default:
            // Handle default case if needed
            break;
        }
      },
      icon: Icon(icon),
    ),
  );
}
}
