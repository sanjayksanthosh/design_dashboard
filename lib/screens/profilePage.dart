import 'package:flutter/material.dart';
import 'package:hidden_dash_new/models/userModel.dart';
import 'package:hidden_dash_new/providers/userProvider.dart';
import 'package:hidden_dash_new/utils/colors.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';
import 'package:hidden_dash_new/widgets/CustomCard.dart';
import 'package:hidden_dash_new/widgets/profileText.dart';
import 'package:provider/provider.dart';

// NEW: Import the transaction model and service.
import 'package:hidden_dash_new/models/transactionModel.dart';
import 'package:hidden_dash_new/services/transaction_services.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  // Sample travel history list.
  List<Map<String, String>> travelHistory = [
    {'date': '2025-01-20', 'route': 'Route 1', 'charge': '₹50'},
    {'date': '2025-01-21', 'route': 'Route 2', 'charge': '₹60'},
  ];

  // The hardcoded rechargeHistory list is no longer used for the Recharge tab.
  List<Map<String, String>> rechargeHistory = [
    {'date': '2025-01-19', 'amount': '₹500'},
    {'date': '2025-01-25', 'amount': '₹300'},
  ];

  // Functions to add or edit entries (omitted here for brevity).
  void addTravelEntry() { /* ... */ }
  void addRechargeEntry() { /* ... */ }
  void editTravelEntry(
      int index,
      TextEditingController dateController,
      TextEditingController routeController,
      TextEditingController chargeController) {
    /* ... */
  }
  void editRechargeEntry(
      int index,
      TextEditingController dateController,
      TextEditingController amountController) {
    /* ... */
  }

  int _selectedIndex = 0;

  // Sample recent travel data (for the Travels tab).
  final List<Map<String, String>> recentTravels = [
    {'Date': '2023-10-05', 'Time': '2:30', 'BusNo': 'Bus No.1'},
    {'Date': '2023-09-30', 'Time': '2:30', 'BusNo': 'Bus No.6'},
    {'Date': '2023-09-20', 'Time': '2:30', 'BusNo': 'Bus No.2'},
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Retrieve the current user from the provider.
  late User _currentUser;

  // Hover states for the buttons.
  bool _isBlockedHovered = false;
  bool _isFreezedHovered = false;

  // NEW: State for fetched recharge transactions.
  List<Transaction> _userTransactions = [];
  bool _isLoadingTransactions = true;
  String? _transactionError;

  @override
  void initState() {
    super.initState();
    _currentUser =
        Provider.of<UserProvider>(context, listen: false).currentUser!;
    // NEW: Fetch the user's recharge transactions.
    fetchUserTransactions();
  }

  /// NEW: Fetch transactions for the current user using the transaction service.
  Future<void> fetchUserTransactions() async {
    try {
      List<Transaction> transactions =
          await TransactionService().fetchTransactionsByUser(_currentUser.userId);
      setState(() {
        _userTransactions = transactions;
        _isLoadingTransactions = false;
      });
    } catch (e) {
      setState(() {
        _transactionError = e.toString();
        _isLoadingTransactions = false;
      });
    }
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

  /// NEW: Build the recharge table using fetched transactions with extended columns.
  Widget _buildRechargeTable() {
    if (_isLoadingTransactions) {
      return const Center(child: CircularProgressIndicator());
    } else if (_transactionError != null) {
      return Center(
        child: Text(
          _transactionError!,
          style: const TextStyle(color: Colors.white),
        ),
      );
    } else if (_userTransactions.isEmpty) {
      return const Center(
        child: Text(
          "No recharge transactions found",
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
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
          rows: _userTransactions.map((transaction) {
            // Format the date & time string.
            final dt = transaction.date.toLocal();
            final dateTimeStr =
                "${dt.day}-${dt.month}-${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
            return DataRow(cells: [
              // Assumes your Transaction model contains these fields.
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

  /// Build the travel table using hardcoded sample data.
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

  @override
  Widget build(BuildContext context) {
    // Determine current status and corresponding button texts.
    final String status = _currentUser.status.toLowerCase();
    final String blockButtonText = status == 'blocked' ? "UnBlock" : "Block";
    final String freezeButtonText =
        status == 'frozen' ? "UnFreeze" : "Freeze";

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
                          // Left side: Glassmorphism card with user details.
                          CustomCard(),
                          // Right side: Freeze/Block buttons.
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
                                            color: Colors.blueAccent),
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
                                          color: Colors.redAccent),
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
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
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
                            Container(
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
                    child: const Center(
                        child: Icon(
                      Icons.close,
                      color: Colors.red,
                    )),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white)),
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
