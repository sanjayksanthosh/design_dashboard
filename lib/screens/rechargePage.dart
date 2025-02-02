import 'package:flutter/material.dart';
import 'package:hidden_dash_new/screens/header.dart';
import 'package:hidden_dash_new/screens/sidebar.dart';
import 'package:hidden_dash_new/utils/colors.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';

class RechargePage extends StatelessWidget {
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Registration Form Container
                        Container(
                          width: context.width/2,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: lightBlack.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Recharge',
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              // First Row
                              Row(
                                children: [
                                  Expanded(child: _buildTextField("User   ID", (value) {})),
                                  SizedBox(width: 10),
                                  Expanded(child: _buildTextField("Name", (value) {})),
                                  SizedBox(width: 10),
                                  Expanded(child: _buildTextField("Emirates ID", (value) {})),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Second Row
                              Row(
                                children: [
                                  Expanded(child: _buildTextField("No. of Days Remaining", (value) {})),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: "Date (Recharge Date)",
                                        labelStyle: const TextStyle(color: Colors.white),
                                        filled: true,
                                        fillColor: const Color.fromARGB(255, 68, 68, 68).withOpacity(0.7),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        suffixIcon: Icon(Icons.calendar_today, color: Colors.white),
                                      ),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        filled: true,
                                        fillColor: const Color.fromARGB(255, 68, 68, 68).withOpacity(0.7),
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("Online Payment", style: TextStyle(color: Colors.white)),
                                          value: "Online Payment",
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Third Row
                              Row(
                                children: [
                                  Expanded(
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        filled: true,
                                        fillColor: const Color.fromARGB(255, 68, 68, 68).withOpacity(0.7),
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("10 Days - AED 50", style: TextStyle(color: Colors.white)),
                                          value: "10 Days - AED 50",
                                        ),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(child: _buildTextField("Remarks", (value) {})),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(Icons.credit_card),
                                      label: Text("Recharge"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor, // Use your primary color
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(Icons.refresh),
                                      label: Text("Clear"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                         ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Recent Recharges Container
                        // Expanded(
                        //   flex: 4,
                        //   child: Container(
                        //     padding: EdgeInsets.all(30),
                        //     decoration: BoxDecoration(
                        //       color: lightBlack.withOpacity(0.9),
                        //       borderRadius: BorderRadius.circular(15.0),
                        //     ),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         const Text(
                        //           'Recent Recharges',
                        //           style: TextStyle(
                        //             fontSize: 24.0,
                        //             fontWeight: FontWeight.bold,
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //         const SizedBox(height: 20.0),
                        //         _buildRecentRechargesList(),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
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

  Widget _buildTextField(String label, Function(String?) onSaved, [String? Function(String?)? validator]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: const Color.fromARGB(255, 68, 68, 68).withOpacity(0.7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: Colors.white),
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }

  Widget _buildRecentRechargesList() {
    return Column(
      children: List.generate(4, (index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: lightBlack.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("User    ID: ${index + 1}", style: TextStyle(color: Colors.white)),
              Text("Date: 1/31/2025", style: TextStyle(color: Colors.white)),
              Text("Amount: AED 50", style: TextStyle(color: Colors.white)),
              Text("Payment: Online", style: TextStyle(color: Colors.white)),
              Text("Remarks: -", style: TextStyle(color: Colors.white)),
            ],
          ),
        );
      }),
    );
  }
}