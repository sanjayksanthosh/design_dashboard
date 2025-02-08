import 'package:flutter/material.dart';
import 'package:hidden_dash_new/models/userModel.dart';
import 'package:hidden_dash_new/providers/transactionProviders.dart';
import 'package:hidden_dash_new/providers/userProvider.dart';
import 'package:hidden_dash_new/utils/colors.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';
import 'package:hidden_dash_new/widgets/CustomCard.dart';
import 'package:hidden_dash_new/widgets/profileText.dart';
import 'package:provider/provider.dart';

// Import the provider for transactions

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  // Hardcoded travel history lists (for demonstration)
  List<Map<String, String>> travelHistory = [
    {'date': '2025-01-20', 'route': 'Route 1', 'charge': '₹50'},
    {'date': '2025-01-21', 'route': 'Route 2', 'charge': '₹60'},
  ];

  // Hardcoded sample data for the Travels tab
  final List<Map<String, String>> recentTravels = [
    {'Date': '2023-10-05', 'Time': '2:30', 'BusNo': 'Bus No.1'},
    {'Date': '2023-09-30', 'Time': '2:30', 'BusNo': 'Bus No.6'},
    {'Date': '2023-09-20', 'Time': '2:30', 'BusNo': 'Bus No.2'},
  ];

  int _selectedIndex = 0;

  // Retrieve the current user from the provider.
  late User _currentUser;

  // Hover states for the buttons.
  bool _isBlockedHovered = false;
  bool _isFreezedHovered = false;

  @override
  void initState() {
    super.initState();
    // Get the current user from the UserProvider
    _currentUser = Provider.of<UserProvider>(context, listen: false).currentUser!;
    
    // Immediately fetch this user's transactions from the TransactionProvider
    Future.microtask(() {
      Provider.of<TransactionProvider>(context, listen: false)
          .fetchTransactionsByUser(_currentUser.userId);
    });
  }

  /// Update the status via the provider and update the local user status.
  Future<void> _updateStatus(String newStatus, [String remarks = ""]) async {
    bool success = await Provider.of<UserProvider>(context, listen: false)
        .updateStatus(_currentUser.userId, newStatus, remarks);
    if (success) {
      setState(() {
        _currentUser.status = newStatus;
      });
    }
  }

  /// Show a dialog to enter remarks before updating the status.
  void _showRemarksDialog(String newStatus) {
    final TextEditingController reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter remarks for $newStatus"),
          content: TextField(
            controller: reasonController,
            decoration: const InputDecoration(hintText: "Enter remarks"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                String reason = reasonController.text.trim();
                if (reason.isEmpty) return;
                await _updateStatus(newStatus, reason);
                Navigator.of(context).pop();
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  /// Handle tab switching (Recharges vs. Travels)
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Build the travel table (uses your local sample data)
  Widget _buildTravelTable() {
    return DataTable(
      columns: const [
        DataColumn(
          label: Text('Date',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('Time',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('Bus No',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
      ],
      rows: recentTravels.map((travel) {
        return DataRow(cells: [
          DataCell(Text(travel['Date']!)),
          DataCell(Text(travel['Time']!)),
          DataCell(Text(travel['BusNo']!)),
        ]);
      }).toList(),
    );
  }

  /// Build the recharge table using TransactionProvider data
  Widget _buildRechargeTable() {
    // Read transaction data/state from the provider
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final isLoading = transactionProvider.isLoading;
    final error = transactionProvider.error;
    final transactions = transactionProvider.transactions;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (error != null) {
      return Center(
        child: Text(
          error,
          style: const TextStyle(color: Colors.white),
        ),
      );
    } else if (transactions.isEmpty) {
      return const Center(
        child: Text(
          "No recharge transactions found",
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      // Build a scrollable DataTable
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text(
                'User ID',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Date & Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Option',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Amount (AED)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Payment Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Remarks',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: transactions.map((transaction) {
            final dt = transaction.date.toLocal();
            final dateTimeStr =
                "${dt.day}-${dt.month}-${dt.year} "
                "${dt.hour.toString().padLeft(2, '0')}:"
                "${dt.minute.toString().padLeft(2, '0')}";

            return DataRow(cells: [
              DataCell(Text(transaction.userId)),
              DataCell(Text(dateTimeStr)),
              DataCell(Text(transaction.type)),
              DataCell(Text("AED ${transaction.amount}")),
              DataCell(Text(transaction.type)),
              DataCell(Text(transaction.description ?? "")),
            ]);
          }).toList(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String status = _currentUser.status.toLowerCase();
    final String blockButtonText = status == 'blocked' ? "UnBlock" : "Block";
    final String freezeButtonText = status == 'frozen' ? "UnFreeze" : "Freeze";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: context.width / 1.2,
                height: context.height / 1.2,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 22.0,
                ),
                decoration: BoxDecoration(
                  color: lightBlack,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Personal Details",
                        style: TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left side: Glassmorphism card with user details
                          CustomCard(),
                          // Right side: Freeze/Block buttons
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Freeze Button (only shown if not blocked)
                              if (status != 'blocked')
                                MouseRegion(
                                  onEnter: (_) {
                                    setState(() {
                                      _isFreezedHovered = true;
                                    });
                                  },
                                  onExit: (_) {
                                    setState(() {
                                      _isFreezedHovered = false;
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      if (freezeButtonText == "Freeze") {
                                        _showRemarksDialog("Frozen");
                                      } else {
                                        _updateStatus("Active");
                                      }
                                    },
                                    child: Container(
                                      width: context.width / 4,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blueAccent,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: status == 'frozen'
                                            ? Colors.blueAccent
                                            : _isFreezedHovered
                                                ? Colors.blueAccent.withOpacity(0.2)
                                                : Colors.transparent,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            freezeButtonText,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const Icon(
                                            Icons.warning_amber_outlined,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 20),
                              // Block Button (always shown)
                              MouseRegion(
                                onEnter: (_) {
                                  setState(() {
                                    _isBlockedHovered = true;
                                  });
                                },
                                onExit: (_) {
                                  setState(() {
                                    _isBlockedHovered = false;
                                  });
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    if (blockButtonText == "Block") {
                                      _showRemarksDialog("Blocked");
                                    } else {
                                      _updateStatus("Active");
                                    }
                                  },
                                  child: Container(
                                    width: context.width / 4,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.redAccent,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      color: status == 'blocked'
                                          ? Colors.redAccent
                                          : _isBlockedHovered
                                              ? Colors.redAccent.withOpacity(0.2)
                                              : Colors.transparent,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          blockButtonText,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        const Icon(
                                          Icons.block,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // History Section (Recharges / Travels)
                      Container(
                        width: context.width,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "History",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _onTabTapped(0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 20.0),
                                          decoration: BoxDecoration(
                                            color: _selectedIndex == 0
                                                ? primaryColor
                                                : Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Text(
                                            'Recharges',
                                            style: TextStyle(
                                              color: _selectedIndex == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _onTabTapped(1),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0,
                                              horizontal: 20.0),
                                          decoration: BoxDecoration(
                                            color: _selectedIndex == 1
                                                ? primaryColor
                                                : Colors.grey[300],
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Text(
                                            'Travels',
                                            style: TextStyle(
                                              color: _selectedIndex == 1
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            SizedBox(
                              width: context.width,
                              child: _selectedIndex == 0
                                  ? _buildRechargeTable()
                                  : _buildTravelTable(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 30,
                top: 30,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
