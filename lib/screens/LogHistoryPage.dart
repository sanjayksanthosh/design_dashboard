// HistoryPage.dart
import 'package:flutter/material.dart';
import 'package:hidden_dash_new/models/transactionModel.dart';
import 'package:hidden_dash_new/providers/transactionProviders.dart';
import 'package:hidden_dash_new/utils/colors.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';
import 'package:hidden_dash_new/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import 'header.dart'; // your header widget
import 'sidebar.dart'; // your sidebar widget

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 0; // Track the selected tab index

  @override
  void initState() {
    super.initState();
    // Fetch transactions when the widget is built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TransactionProvider>(context, listen: false).fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(), // Your sidebar widget
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Header(), // Your header widget
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        transform: Matrix4.translationValues(0, -80, 0),
                        width: context.width / 1.3,
                        height: 600, // Fixed height container
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
    // Hardcoded data for Travel History
    List<Map<String, dynamic>> travelHistory = [
      {
        "userId": "1",
        "inTime": "12:38:51 AM",
        "date": "2024-10-01",
        "busNo": "2",
        "staff": "12",
        "remainingBalance": "9.50",
      },
    ];
    return buildHistoryCards(travelHistory);
  }

  Widget buildRechargeHistory() {
    // Hardcoded data for Recharge History
    List<Map<String, dynamic>> rechargeHistory = [
      {
        "userId": "1",
        "date": "2024-10-01",
        "time": "10:00 AM",
        "option": "Online",
        "amount": "50.00",
        "paymentMethod": "Card",
        "remarks": "Recharge (10 Days)",
      },
    ];
    return buildRechargeCards(rechargeHistory);
  }

  Widget buildFinancialTransactions() {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(child: LoadingWidget());
        } else if (provider.error != null) {
          return Center(
            child: Text(
              'Error: ${provider.error}',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else if (provider.transactions.isEmpty) {
          return Center(
            child: Text(
              'No transactions found',
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          // The header remains fixed and the list scrolls.
          return buildFinancialCards(provider.transactions);
        }
      },
    );
  }

  Widget buildIncidents() {
    // Hardcoded data for Incidents
    List<Map<String, dynamic>> incidents = [
      {
        "userId": "1",
        "type": "Reported",
        "timestamp": "2024-10-01 10:00 AM",
        "action": "Reported",
      },
    ];
    return buildIncidentCards(incidents);
  }

  // Helper method: Build table header widget
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
          return Container(
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              header,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper method: Build Travel History cards
  Widget buildHistoryCards(List<Map<String, dynamic>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTableHeader(
            ["User ID", "In Time", "Date", "Bus No", "Staff", "Remaining Balance"]),
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
                  width: 100,
                  child: Text(
                    row["userId"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    row["inTime"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    row["date"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
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
                  width: 100,
                  child: Text(
                    row["staff"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
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

  // Helper method: Build Recharge History cards
  Widget buildRechargeCards(List<Map<String, dynamic>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTableHeader(
            ["User ID", "Date & Time", "Option", "Amount", "Payment Method", "Remarks"]),
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
                  width: 100,
                  child: Text(
                    row["userId"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    "${row["date"]} ${row["time"]}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    row["option"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    "${row["amount"]} AED",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
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

  // Updated: Build Financial Transactions cards with a scrollable list inside.
  Widget buildFinancialCards(List<Transaction> transactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTableHeader(
            ["Transaction ID", "Date", "Type", "User ID", "Amount", "Full Name"]),
        // Wrap the list of transaction rows inside an Expanded ListView
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
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
                      width: 100,
                      child: Text(
                        transaction.transactionId,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        transaction.date.toLocal().toString().split(' ')[0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        transaction.type,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        transaction.userId,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        "${transaction.amount} AED",
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        transaction.fullName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  // Helper method: Build Incident cards for the Incidents tab
  Widget buildIncidentCards(List<Map<String, dynamic>> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTableHeader(["User ID", "Type", "Timestamp", "Action"]),
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
                  width: 100,
                  child: Text(
                    row["userId"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    row["type"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Text(
                    row["timestamp"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ),
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
}
