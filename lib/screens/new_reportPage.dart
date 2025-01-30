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
                            // _reportList(),
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
  List invoices = [
    {
      "name": "Arlene McCoy",
      "date": "31 Aug 2023",
      "amount": "\$3,230.2",
      "productId": "001423",
      "status": "Paid",
      "statusColor": Colors.green,
    },
    {
      "name": "Jacob Jones",
      "date": "30 Aug 2023",
      "amount": "\$6,630.5",
      "productId": "004533",
      "status": "Unpaid",
      "statusColor": Colors.orange,
    },
    {
      "name": "Marvin Butcher",
      "date": "30 Aug 2023",
      "amount": "\$4,230.0",
      "productId": "001784",
      "status": "Paid",
      "statusColor": Colors.green,
    },
    {
      "name": "Ralph Edwards",
      "date": "29 Aug 2023",
      "amount": "\$3,082.2",
      "productId": "001515",
      "status": "Paid",
      "statusColor": Colors.green,
    },
      {
      "name": "Ralph Edwards",
      "date": "29 Aug 2023",
      "amount": "\$3,082.2",
      "productId": "001515",
      "status": "Paid",
      "statusColor": Colors.green,
    },  {
      "name": "Ralph Edwards",
      "date": "29 Aug 2023",
      "amount": "\$3,082.2",
      "productId": "001515",
      "status": "Paid",
      "statusColor": Colors.green,
    },  {
      "name": "Ralph Edwards",
      "date": "29 Aug 2023",
      "amount": "\$3,082.2",
      "productId": "001515",
      "status": "Paid",
      "statusColor": Colors.green,
    },  {
      "name": "Ralph Edwards",
      "date": "29 Aug 2023",
      "amount": "\$3,082.2",
      "productId": "001515",
      "status": "Paid",
      "statusColor": Colors.green,
    },  {
      "name": "Ralph Edwards",
      "date": "29 Aug 2023",
      "amount": "\$3,082.2",
      "productId": "001515",
      "status": "Paid",
      "statusColor": Colors.green,
    },
  ];

  return Container(
    width: context.width/3,
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
          "Reports",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "3,251 invoices",
          style: TextStyle(
            color: Colors.white54,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: invoices.length,
            itemBuilder: (context, index) {
              final invoice = invoices[index];

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
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade700,
                          child: Text(
                            invoice["name"]![0],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              invoice["name"]!,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              invoice["date"]!,
                              style: const TextStyle(color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          invoice["amount"]!,
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          invoice["productId"]!,
                          style: const TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: invoice["statusColor"],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        invoice["status"]!,
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




  Widget _reportList() {
    return Container(
      width: context.width / 3,
      height: context.height / 1.35,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: lightBlack.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [Row()],
      ),
    );
  }
}
