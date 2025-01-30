import 'package:flutter/material.dart';
import 'package:hidden_dash_new/screens/header.dart';
import 'package:hidden_dash_new/screens/profilePage.dart';
import 'package:hidden_dash_new/screens/sidebar.dart';
import '../../utils/colors.dart'; // Ensure you have your color definitions here
import '../../utils/media_query_values.dart'; // Ensure you have your media query extension here

class UserSearchPage extends StatefulWidget {
  @override
  _UserSearchPageState createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  final List<Map<String, String>> users = [
    {'userId': 'U123', 'fullName': 'John Doe', 'phoneNumber': '1234567890'},
    {'userId': 'U124', 'fullName': 'Jane Smith', 'phoneNumber': '0987654321'},
    {
      'userId': 'U125',
      'fullName': 'Alice Johnson',
      'phoneNumber': '1122334455'
    },
    {'userId': 'U126', 'fullName': 'Bob Brown', 'phoneNumber': '2233445566'},
     {'userId': 'U123', 'fullName': 'John Doe', 'phoneNumber': '1234567890'},
    {'userId': 'U124', 'fullName': 'Jane Smith', 'phoneNumber': '0987654321'},
    {
      'userId': 'U125',
      'fullName': 'Alice Johnson',
      'phoneNumber': '1122334455'
    },
    {'userId': 'U126', 'fullName': 'Bob Brown', 'phoneNumber': '2233445566'},
    // Add more users as needed
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('User  Search'),
      //   backgroundColor: primaryColor, // Use your primary color
      // ),
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Header(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: context.width/1.3,
                      height: context.height,
                      transform: Matrix4.translationValues(0, -150, 0),
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: lightBlack.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSearchField(),
                          // Container(height: 50,width: 200,decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(15),
                          //   color: primaryColor),child: Center(child: Text("Search"),),),
                          const SizedBox(height: 20.0),
                          Expanded(
                            child: _buildUserTable(),
                          ),
                        ],
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

  Widget _buildSearchField() {
    return Container(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Search Users',
          labelStyle: const TextStyle(color: Colors.white),
          // fillColor: lightBlack.withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          setState(() {
            searchQuery = value.toLowerCase();
          });
        },
      ),
    );
  }

  Widget _buildUserTable() {
    final filteredUsers = users.where((user) {
      return user['fullName']!.toLowerCase().contains(searchQuery) ||
          user['userId']!.toLowerCase().contains(searchQuery) ||
          user['phoneNumber']!.toLowerCase().contains(searchQuery);
    }).toList();

    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return _buildUserContainer(user);
      },
    );
  }

  Widget _buildUserContainer(Map<String, String> user) {
    return InkWell(
        onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Profilepage(),
                );
              },
            ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 28, 28, 28).withOpacity(0.7),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        user['fullName']!,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'User  ID: ${user['userId']}',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 220,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Center(child: Text("Block")),
                          height: 30,width: 100,decoration: BoxDecoration(border: Border.all(color: Colors.redAccent),borderRadius: BorderRadius.circular(30))),
                         Container(
                          child: Center(child: Text("Freeze")),
                          height: 30,width: 100,decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent),borderRadius: BorderRadius.circular(30))),
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 8.0),
              Divider(color: Colors.white54), // Divider for separation
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emirates ID: ${user['emiratesId'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Card Type: ${user['cardType'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Status: ${user['status'] ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: user['status'] == 'Active'
                          ? Colors.green
                          : user['status'] == 'Blocked'
                              ? Colors.red
                              : Colors.orange, // Color based on status
                    ),
                  ),
                  Text(
                    'Balance: ${user['balance'] ?? '0.00'}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Expiration: ${user['expiration'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
