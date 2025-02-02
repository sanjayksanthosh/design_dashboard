import 'package:flutter/material.dart';
import 'package:hidden_dash_new/screens/header.dart';
import 'package:hidden_dash_new/screens/sidebar.dart';
import 'package:hidden_dash_new/utils/colors.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 0; // Track the selected tab index

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
                  Header(),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                          Container(
      transform: Matrix4.translationValues(0, -80, 0),

                            width: context.width / 1.3,
                            height: 600, // Set a specific height for the container
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: lightBlack.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "History",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    _buildPillButton("Travel History", 0),
                                    _buildPillButton("Recharge History", 1),
                                    _buildPillButton("Financial Transactions", 2),
                                    _buildPillButton("Incidents", 3),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Expanded(
                                  child: _getTabContent(),
                                ),
                              ],
                            ),
                          ),
                          // Optional: Add a transparent container to capture taps
                        
                        
                      
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPillButton(String title, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _selectedIndex == index ? primaryColor : Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _getTabContent() {
    switch (_selectedIndex) {
      case 0:
        return buildTravelHistory();
      case 1:
        return buildRechargeHistory();
      case 2:
        return buildFinancialTransactions();
      case 3:
        return buildIncidents();
      default:
        return Container();
    }
  }

  Widget buildTravelHistory() {
    List<Map<String, dynamic>> travelHistory = [
      {
        "userId": "1",
        "inTime": "12:38:51 AM",
        "date": "1/31/2025",
        "busNo": "2",
        "staff": "12",
        "remainingBalance": "9.50",
      },
      {
        "userId": "2",
        "inTime": "1:00:00 AM",
        "date": "1/31/2025",
        "busNo": "3",
        "staff": "15",
        "remainingBalance": "8.00",
      },
      {
        "userId": "3",
        "inTime": "1:30:00 AM",
        "date": "1/31/2025",
        "busNo": "4",
        "staff": "10",
        "remainingBalance": "7.50",
      },
      {
        "userId": "4",
        "inTime": "2:00:00 AM",
        "date": "1/31/2025",
        "busNo": "5",
        "staff": "20",
        "remainingBalance": "6.00",
      },
    ];

    return buildHistoryCards(travelHistory);
  }

  Widget buildRechargeHistory() {
    List<Map<String, dynamic>> rechargeHistory = [
      {
        "userId": "1",
        "date": "1/31/2025",
        "time": "10:00 AM",
        "option": "Online",
        "amount": "50.00",
        "paymentMethod": "Credit Card",
        "remarks": "Recharge (10 Days)",
      },
      {
        "userId": "2",
        "date": "1/31/2025",
        "time": "11:00 AM",
        "option": "App",
        "amount": "30.00",
        "paymentMethod": "Debit Card",
        "remarks": "Recharge (5 Days)",
      },
      {
        "userId": "3",
        "date": "1/31/2025",
        "time": "12:00 PM",
        "option": "Website",
        "amount": "20.00",
        "paymentMethod": "PayPal",
        "remarks": "Recharge (3 Days)",
      },
      {
        "userId": "4",
        "date": "1/31/2025",
        "time": "1:00 PM",
        "option": "In-Person",
        "amount": "40.00",
        "paymentMethod": "Cash",
        "remarks": "Recharge (8 Days)",
      },
    ];

    return buildRechargeCards(rechargeHistory);
  }

  Widget buildFinancialTransactions() {
    List<Map<String, dynamic>> financialTransactions = [
      {
        "transactionId": "FT1001",
        "date": "1/31/2025",
        "time": "10:00 AM",
        "type": "Credit",
        "userId": "1",
        "amount": "50.00",
        "details": "Recharge",
      },
      {
        "transactionId": "FT1002",
        "date": "1/31/2025",
        "time": "11:00 AM",
        "type": "Debit",
        "userId": "2",
        "amount": "30.00",
        "details": "Bus Fare",
      },
      {
        "transactionId": "FT1003",
        "date": "1/31/2025",
        "time": "12:00 PM",
        "type": "Credit",
        "userId": "3",
        "amount": "20.00",
        "details": "Recharge",
      },
      {
        "transactionId": "FT1004",
        "date": "1/31/2025",
        "time": "1:00 PM",
        "type": "Debit",
        "userId": "4",
        "amount": "40.00",
        "details": "Bus Fare",
      },
    ];

    return buildFinancialCards(financialTransactions);
  }

  Widget buildIncidents() {
    List<Map<String, dynamic>> incidents = [
      {
        "userId": "1",
        "type": "Reported",
        "timestamp": "1/31/2025 10:00 AM",
        "action": "Reported",
      },
      {
        "userId": "2",
        "type": "Alerted",
        "timestamp": "1/31/2025 11:00 AM",
        "action": "Resolved",
      },
      {
        "userId": "3",
        "type": "Notified",
        "timestamp": "1/31/2025 12:00 PM",
        "action": "Notified",
      },
      {
        "userId": "4",
        "type": "Resolved",
        "timestamp": "1/31/2025 1:00 PM",
        "action": "Closed",
      },
    ];

    return buildIncidentCards(incidents);
  }

  Widget buildHistoryCards(List<Map<String, dynamic>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTableHeader(["User    ID", "In Time", "Date", "Bus No", "Staff", "Remaining Balance"]),
        ...data.map((row) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 21, 21, 27),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["userId"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["inTime"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["date"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                // Bus No. with a pill-like design
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    row["busNo"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["staff"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                // Remaining Balance with a pill-like design
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${row["remainingBalance"]} Days",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget buildRechargeCards(List<Map<String, dynamic>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTableHeader(["User    ID", "Date & Time", "Option", "Amount (AED)", "Payment Method", "Remarks"]),
        ...data.map((row) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 21, 21, 27),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["userId"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    "${row["date"]} ${row["time"]}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["option"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    "${row["amount"]} AED",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                // Payment Method with a pill-like design
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    row["paymentMethod"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                // Remarks with a pill-like design
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    row["remarks"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget buildFinancialCards(List<Map<String, dynamic>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTableHeader(["Transaction ID", "Date & Time", "Type", "User    ID", "Amount (AED)", "Details"]),
        ...data.map((row) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 21, 21, 27),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["transactionId"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    "${row["date"]} ${row["time"]}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["type"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["userId"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    "${row["amount"]} AED",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                // Details with a pill-like design
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    row["details"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget buildIncidentCards(List<Map<String, dynamic>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTableHeader(["User    ID", "Type", "Timestamp", "Action"]),
        ...data.map((row) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 21, 21, 27),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["userId"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["type"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 100, // Set a specific width for the cell
                  child: Text(
                    row["timestamp"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                // Action with a pill-like design
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    row["action"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTableHeader(List<String> headers) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 73, 72, 72).withOpacity(0.8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: headers.map((header) {
          return GestureDetector(
            onTap: () {
              // Handle the tap event here
              print("Header tapped: $header");
            },
            child: Container(
              width: 100, // Set a specific width for the header cell
              alignment: Alignment.center, // Center the text
              padding: const EdgeInsets.symmetric(vertical: 12), // Add some vertical padding
              decoration: BoxDecoration(
                color: Colors.grey[800], // Background color for the header
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Text(
                header,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}