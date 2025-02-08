import 'package:flutter/material.dart';
import 'package:hidden_dash_new/screens/header.dart';
import 'package:hidden_dash_new/screens/sidebar.dart';
import 'package:hidden_dash_new/widgets/graph_overview.dart';
import '../../utils/colors.dart'; // Ensure you have your color definitions here
import '../../utils/media_query_values.dart'; // Ensure you have your media query extension here

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<Map<String, String>> reports = [
    {'date': '2023-10-01', 'type': 'Travel', 'amount': '₹50'},
    {'date': '2023-09-28', 'type': 'Recharge', 'amount': '₹30'},
    {'date': '2023-09-25', 'type': 'Travel', 'amount': '₹20'},
    {'date': '2023-09-20', 'type': 'Recharge', 'amount': '₹40'},
    // Add more reports as needed
  ];

  String searchQuery = '';
  String selectedReportType = '';
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            // Removed the outer SingleChildScrollView so that the scroll happens only
            // within the container below.
            child: Stack(
              children: [
                Header(),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: context.width / 1.3,
                      height: context.height / 1.3,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: lightBlack.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      // Wrap the container's content with a SingleChildScrollView.
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildReportFilter(),
                            const SizedBox(height: 20.0),
                            GrapghOverview(),
                            const SizedBox(height: 20.0),
                            _buildReportTable(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Filter Reports",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedReportType.isEmpty ? null : selectedReportType,
          hint: const Text(
            'Select Report Type',
            style: TextStyle(color: Colors.white),
          ),
          items: [
            DropdownMenuItem(
              value: '',
              child: Text(
                'Select...',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 'financial',
              child: Text(
                'Financial Report',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 'lowBalance',
              child: Text(
                'Low Balance',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 'expiredCards',
              child: Text(
                'Expired Cards',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 'whiteSummary',
              child: Text(
                'White Cards Summary',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 'cashTransactions',
              child: Text(
                'Cash Transactions',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 'cardTransactions',
              child: Text(
                'Card Transactions',
                style: TextStyle(color: Colors.white),
              ),
            ),
            DropdownMenuItem(
              value: 'refundReport',
              child: Text(
                'Refund Report',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          onChanged: (value) {
            setState(() {
              selectedReportType = value!;
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: lightBlack.withOpacity(0.7),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Start Date (mm/dd/yyyy)',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: lightBlack.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  // Handle start date input
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'End Date (mm/dd/yyyy)',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: lightBlack.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  // Handle end date input
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReportTable() {
    final filteredReports = reports.where((report) {
      // Filter reports based on the search query
      return report['type']!.toLowerCase().contains(searchQuery) ||
          report['date']!.toLowerCase().contains(searchQuery) ||
          report['amount']!.toLowerCase().contains(searchQuery);
    }).toList();

    // Wrap the ListView in a way that it does not scroll on its own,
    // so that the outer SingleChildScrollView manages scrolling.
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredReports.length,
      itemBuilder: (context, index) {
        final report = filteredReports[index];
        return _buildReportContainer(report);
      },
    );
  }

  Widget _buildReportContainer(Map<String, String> report) {
    return InkWell(
      onTap: () {
        // Handle report tap, e.g., show details
      },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date: ${report['date']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Type: ${report['type']}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Amount: ${report['amount']}',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Divider(color: Colors.white54),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Status: ${report['status'] ?? 'N/A'}',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: report['status'] == 'Completed'
                        ? Colors.green
                        : report['status'] == 'Pending'
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
                Text(
                  'Details: ${report['details'] ?? 'N/A'}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
