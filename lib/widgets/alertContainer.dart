import 'package:flutter/material.dart';
import '../../utils/colors.dart';
import '../../utils/media_query_values.dart';

class AlertsContainer extends StatelessWidget {
  const AlertsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // transform: Matrix4.translationValues(0, -70, 0),
height: context.height/2.2,
     width: context.width * 0.18,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: lightBlack.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Alerts',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          _alertItem("Car Declined", "Your last transaction was declined."),
          _alertItem("Low Balance", "Your balance is below \$50."),
          _alertItem("Maintenance Required", "Service your vehicle soon."),
          // Add more alerts as needed
        ],
      ),
    );
  }

  Widget _alertItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 65, 64, 64).withOpacity(0.8),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}