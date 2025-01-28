import 'package:flutter/material.dart';
import 'package:hidden_dash_new/utils/colors.dart';
import 'package:hidden_dash_new/utils/media_query_values.dart';
import 'package:hidden_dash_new/widgets/total_widget.dart';
import 'package:percent_indicator/percent_indicator.dart'; // Make sure to add this package to your pubspec.yaml

class OverviewStatistic extends StatefulWidget {
  const OverviewStatistic({super.key});

  @override
  State<OverviewStatistic> createState() => _OverviewStatisticState();
}

class _OverviewStatisticState extends State<OverviewStatistic> {
  // Sample bus data
  List<Map<String, dynamic>> _busData = [
    {
      'name': 'Bus 1',
      'passengers': 15,
      'activeStaff': 3,
      'totalPassengers': 45,
      'activeBus': 'Yes',
    },
    {
      'name': 'Bus 2',
      'passengers': 20,
      'activeStaff': 4,
      'totalPassengers': 45,
      'activeBus': 'Yes',
    },
    {
      'name': 'Bus 3',
      'passengers': 10,
      'activeStaff': 2,
      'totalPassengers': 45,
      'activeBus': 'No',
    },
  ];

  int _selectedBusIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.45,
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 22.0,
      ),
      transform: Matrix4.translationValues(0, -70, 0),
      decoration: BoxDecoration(
        color: lightBlack, // Keep the original color
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Live Insights',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.insert_drive_file_rounded,
                color: darkGrey,
                size: 15.0,
              ),
              SizedBox(width: context.width * 0.01),
              const Icon(
                Icons.star,
                color: primaryColor,
                size: 15.0,
              ),
              SizedBox(width: context.width * 0.01),
              const Icon(
                Icons.settings,
                color: darkGrey,
                size: 15.0,
              ),
            ],
          ),
          SizedBox(height: context.height * 0.025),
          Container(
            width: context.width * 0.3,
            height: context.height * 0.09,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: darkBlack,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_busData.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBusIndex = index;
                    });
                  },
                  child: _tabWidget(context, index, _busData[index]['name']),
                );
              }),
            ),
          ),
          SizedBox(height: context.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircularPercentIndicator(
                radius: 80.0,
                lineWidth: 12.0,
                percent: _busData[_selectedBusIndex]['passengers'] / 45,
                center: Stack(
                  children: [
                    SizedBox(
                      width: context.width * 0.045,
                      child: Text(
                        '${_busData[_selectedBusIndex]['passengers']}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        '/45',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
                progressColor: primaryColor,
                backgroundColor: const Color.fromARGB(129, 81, 81, 81),
              ),
              Column(
                children: [
                  TotalWidget(
                    title: "Active Staff",
                    content: "${_busData[_selectedBusIndex]['activeStaff']}",
                  ),
                  TotalWidget(
                    title: "Total Passengers Travelled",
                    content:
                        "${_busData[_selectedBusIndex]['totalPassengers']}",
                  ),
                ],
              ),
              Column(
                children: [
                  TotalWidget(
                        title: "Active Bus",
                        content:
                            "${_busData[_selectedBusIndex]['activeBus']}",
                      ),
                       TotalWidget(
                    title: "Total Incidents",
                    content:
                        "${_busData[_selectedBusIndex]['totalPassengers']}",
                  ),
                ],
              ),
                  
             
            ],
          ),
          SizedBox(height: context.height * 0.02),
        ],
      ),
    );
  }

  Container _tabWidget(BuildContext context, int index, String busName) {
    return Container(
      width: context.width * 0.05,
      height: context.height * 0.08,
      decoration: BoxDecoration(
        color: lightBlack, // Maintain the original color
        borderRadius: BorderRadius.circular(12.0),
        gradient: index == _selectedBusIndex
            ? const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [primaryColor, secondPrimaryColor],
              )
            : null,
      ),
      child: Center(
        child: Text(
          busName,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: index == _selectedBusIndex ? Colors.white : Colors.grey,
                fontSize: 15.0,
              ),
        ),
      ),
    );
  }
}
