// screens/user_search_page.dart
import 'package:flutter/material.dart';
import 'package:hidden_dash_new/models/userModel.dart';
import 'package:hidden_dash_new/providers/userProvider.dart';
import 'package:hidden_dash_new/screens/profilePage.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';
import 'package:hidden_dash_new/widgets/loading_widget.dart';
import 'package:hidden_dash_new/widgets/statusButton.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'header.dart';
import 'sidebar.dart';
import '../../utils/colors.dart';

class UserSearchPage extends StatefulWidget {
  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  @override
  void initState() {
    super.initState();
    // Fetch users when the page is initialized
    Provider.of<UserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Stack to layer the header and the search/table container.
                  Stack(
                    children: [
                      // Background container covering the full screen.
                      Container(
                        width: context.width,
                        height: context.height,
                      ),
                      // Fixed header at the top.
                      Header(),
                      // Positioned container for the search field and user list.
                      Positioned(
                        top: 100,
                        left: context.width / 35,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: context.height / 1.3,
                            width: context.width / 1.2,
                            decoration: BoxDecoration(
                              color: lightBlack.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSearchField(),
                                const SizedBox(height: 20),
                                // Expanded widget to allow the user list to scroll.
                                Expanded(child: _buildUserTable()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the search text field.
  Widget _buildSearchField() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search Users',
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          Provider.of<UserProvider>(context, listen: false)
              .setSearchQuery(value);
        },
      ),
    );
  }

  /// Builds the list of users.
  Widget _buildUserTable() {
    
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final users = userProvider.users;
        if (users.isEmpty) {
          return const Center(child: LoadingWidget());
        }
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return _buildUserContainer(user);
          },
        );
      },
    );
  }
  

  /// Builds the container that displays user information.
  Widget _buildUserContainer(User user) {
    return InkWell(
      onTap: () {
        // Set the selected user in the provider.
        Provider.of<UserProvider>(context, listen: false).setCurrentUser(user);
        // Show the user's profile in a dialog.
 DateTime utcDateTime = DateTime.parse(user.idExpiration.toString());
 DateTime localDateTime = utcDateTime.toLocal();
 String formatted = DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Profilepage(),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 28, 28, 28).withOpacity(0.7),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row with user basic information and status button.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'User ID: ${user.userId}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                UserStatusButtons(user: user),
              ],
            ),
            const SizedBox(height: 8.0),
            const Divider(color: Colors.white54),
            const SizedBox(height: 8.0),
            // Row with additional user details.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Emirates ID: ${user.emiratesIdNo ?? 'N/A'}',
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                Text(
                  'Card Type: ${user.cardType ?? 'N/A'}',
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                Text(
                  'Status: ${user.status ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: user.status == 'active'
                        ? Colors.green
                        : user.status == 'blocked'
                            ? Colors.red
                            : user.status == 'frozen'
                                ? Colors.blue
                                : Colors.amber,
                  ),
                ),
                Text(
                  'Balance: ${user.status == 'blocked' ? "0.00" : user.balance}',
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                ),
                Text(
                  'Expiration: ${user.idExpiration.toString()}',
                  style: const TextStyle(fontSize: 14.0, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
}
