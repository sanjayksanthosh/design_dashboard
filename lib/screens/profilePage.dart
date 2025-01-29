import 'package:flutter/material.dart';
import 'package:hidden_dash_new/utils/colors.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';
import 'package:hidden_dash_new/widgets/profileText.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  // List to hold travel history
  List<Map<String, String>> travelHistory = [
    {'date': '2025-01-20', 'route': 'Route 1', 'charge': '₹50'},
    {'date': '2025-01-21', 'route': 'Route 2', 'charge': '₹60'},
  ];

  // List to hold recent recharge details
  List<Map<String, String>> rechargeHistory = [
    {'date': '2025-01-19', 'amount': '₹500'},
    {'date': '2025-01-25', 'amount': '₹300'},
  ];

  // Function to add a travel entry
  void addTravelEntry() {
    setState(() {
      travelHistory.add({
        'date': DateTime.now().toString().split(' ')[0],
        'route': 'Route ${travelHistory.length + 1}',
        'charge': '₹${(50 + travelHistory.length * 10)}',
      });
    });
  }

  // Function to add a recharge entry
  void addRechargeEntry() {
    setState(() {
      rechargeHistory.add({
        'date': DateTime.now().toString().split(' ')[0],
        'amount': '₹${(500 + rechargeHistory.length * 100)}',
      });
    });
  }

  // Function to handle editing of a travel history entry
  void editTravelEntry(
      int index,
      TextEditingController dateController,
      TextEditingController routeController,
      TextEditingController chargeController) {
    setState(() {
      travelHistory[index] = {
        'date': dateController.text,
        'route': routeController.text,
        'charge': chargeController.text,
      };
    });
  }

  // Function to handle editing of a recharge history entry
  void editRechargeEntry(int index, TextEditingController dateController,
      TextEditingController amountController) {
    setState(() {
      rechargeHistory[index] = {
        'date': dateController.text,
        'amount': amountController.text,
      };
    });
  }

  int _selectedIndex = 0;

  // List of widgets to display for each tab
  final List<Map<String, String>> recentRecharges = [
    {'Date': '2023-10-01', 'Time': '2:30', 'Amount': '\$50'},
    {'Date': '2023-09-28', 'Time': '2:30', 'Amount': '\$30'},
    {'Date': '2023-09-25', 'Time': '2:30', 'Amount': '\$20'},
    {'Date': '2023-09-25', 'Time': '2:30', 'Amount': '\$20'},
    {'Date': '2023-09-25', 'Time': '2:30', 'Amount': '\$20'},
    {'Date': '2023-09-25', 'Time': '2:30', 'Amount': '\$20'},
  ];

  // Sample data for recent travels
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

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Personal Details",
                          style: TextStyle(fontSize: 40),
                        ),
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 300,
                                  width: context.width / 5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                SizedBox(width: 50),
                                Column(
                                  children: [
                                    Profiletext(
                                      title: "name",
                                      content: "samad aksdal",
                                    ),
                                    Profiletext(
                                      title: "userId",
                                      content: "A10293",
                                    ),
                                    Profiletext(
                                      title: "Phone",
                                      content: "392019301",
                                    ),
                                    Profiletext(
                                      title: "emiratesIdNo",
                                      content: "3298329832",
                                    ),
                                    Profiletext(
                                      title: "Country",
                                      content: "India",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              height: context.height / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),
                                    height: 200,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  SizedBox(
                                    width: context.width / 4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 150,
                    
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueAccent),
                                            borderRadius: BorderRadius.circular(20),
                                            // color: const Color.fromARGB(255, 54, 105, 244),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text("Freeze"),
                                              ),
                                              Icon(Icons.warning_amber_outlined)
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.redAccent),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          // color: Colors.red),
                                          padding: EdgeInsets.all(10),
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Text("Block"),
                                              ),
                                              Icon(Icons.block)
                    
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Travel History Table
                        Container(
                          width: context.width,
                          // height: 400,
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 20.0),
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 20.0),
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
                                  SizedBox(
                                      width: 400,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ))
                                ],
                              ),
                              SizedBox(
                                  height: 16.0), // Space between tabs and content
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
                      child: Center(child: Icon(Icons.close,color: Colors.red,),),
                      decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      
    );
  }

  Widget _buildRechargeTable() {
    return DataTable(
      columns: [
        DataColumn(
          label: Text('Date',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        DataColumn(
          label: Text('Time',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        DataColumn(
            label: Text('Amount',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
      ],
      rows: recentRecharges.map((recharge) {
        return DataRow(cells: [
          DataCell(Text(recharge['Date']!)),
          DataCell(Text(recharge['Time']!)),
          DataCell(Text(recharge['Amount']!)),
        ]);
      }).toList(),
    );
  }

  Widget _buildTravelTable() {
    return DataTable(
      columns: [
        DataColumn(
            label: Text(
          'Date',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        DataColumn(
            label: Text(
          'Time',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        DataColumn(
            label: Text('Bus No',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
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
}
