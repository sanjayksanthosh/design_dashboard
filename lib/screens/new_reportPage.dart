import 'package:flutter/material.dart';
import 'package:hidden_dash_new/screens/header.dart';
import 'package:hidden_dash_new/screens/sidebar.dart';
import 'package:hidden_dash_new/utils/colors.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';
import 'package:hidden_dash_new/widgets/graph_overview.dart';

class NewReportpage extends StatefulWidget {
  const NewReportpage({super.key});

  @override
  State<NewReportpage> createState() => _NewReportpageState();
}

class _NewReportpageState extends State<NewReportpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                Header(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: context.width / 1.3,
                    height: context.height / 1.2,
                    transform: Matrix4.translationValues(0, -150, 0),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: lightBlack.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GrapghOverview(),
                            buildInvoicesContainer(),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget buildInvoicesContainer() {
    List<Map<String, dynamic>> transactions = [
      {
        "transactionId": "FT1000",
        "date": "1/31/2025, 12:35:50 AM",
        "type": "Credit",
        "userId": "-",
        "amount": "0.00",
        "details": "Opening Balance",
      },
      {
        "transactionId": "FT1001",
        "date": "1/31/2025, 12:36:59 AM",
        "type": "Credit",
        "userId": "1",
        "amount": "50.00",
        "details": "Recharge (10 Days)",
      },
      {
        "transactionId": "FT1002",
        "date": "1/31/2025, 12:38:51 AM",
        "type": "Debit",
        "userId": "1",
        "amount": "0.50",
        "details": "Scan on Bus 2 by Staff 12",
      },
    ];

    return Container(
      width: context.width / 3,
      height: 500,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lightBlack.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transaction Reports",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "${transactions.length} transactions",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction["transactionId"]!,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            transaction["date"]!,
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${transaction["amount"]} AED",
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            transaction["details"]!,
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: transaction["type"] == "Credit" ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          transaction["type"]!,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      const Icon(Icons.more_horiz, color: Colors.white54),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}