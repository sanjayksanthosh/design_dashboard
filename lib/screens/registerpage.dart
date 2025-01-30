import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User  Registration'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 22.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[900], // lightBlack equivalent
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Personal Details",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildTextField("User  ID", "e.g., U123")),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField("Full Name", "e.g., Samad Aksdal")),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildTextField("Phone Number", "e.g., 392019301")),
                  const SizedBox(width: 10),
                  Expanded(child: _buildTextField("Emirates ID No", "e.g., 3298329832")),
                ],
              ),
              const SizedBox(height: 10),
              _buildCardTypeDropdown(),
              const SizedBox(height: 10),
              _buildTextField("ID Expiration Date", "e.g., 2023-12-31"),
              const SizedBox(height: 10),
              _buildTextField("Balance (in days)", "e.g., 30"),
              const SizedBox(height: 10),
              _buildTextField("Remarks", "e.g., No remarks"),
              const SizedBox(height: 10),
              _buildStatusDropdown(),
              const SizedBox(height: 10),
              _buildTextField("Company Name", "e.g., My Company"),
              const SizedBox(height: 10),
              _buildTextField("Store Name", "e.g., My Store"),
              const SizedBox(height: 10),
              _buildTextField("Pick Location", "e.g., Dubai"),
              const SizedBox(height: 10),
              _buildOnlineCompanyToggle(),
              const SizedBox(height: 20),
              _buildImageUploadSection(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle registration logic here
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCardTypeDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Card Type",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        items: const [
          DropdownMenuItem(value: 'EID', child: Text('EID')),
          DropdownMenuItem(value: 'White', child: Text('White')),
        ],
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Status",
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        items: const [
          DropdownMenuItem(value: 'Active', child: Text('Active')),
          DropdownMenuItem(value: 'Blocked', child: Text('Blocked')),
          DropdownMenuItem(value: 'Frozen', child: Text('Frozen')),
        ],
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildOnlineCompanyToggle() {
    bool isOnline = false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Online Company", style: TextStyle(color: Colors.white)),
          Switch(
            value: isOnline,
            onChanged: (value) {
              isOnline = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadSection() {
    return Center(
      child: Column(
        children: [
          const Text("Upload Image", style: TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // Handle image upload logic here
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white),
              ),
              child: const Icon(Icons.upload_file, color: Colors.white, size: 50),
            ),
          ),
        ],
      ),
    );
  }
}