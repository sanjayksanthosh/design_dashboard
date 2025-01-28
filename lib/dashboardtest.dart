import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF5F6FA),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) => setState(() => _selectedIndex = index),
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text('People'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.work),
                label: Text('Hiring'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.devices),
                label: Text('Devices'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calendar_today),
                label: Text('Calendar'),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: 24),
                  _buildStatsRow(),
                  SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildCalendar(),
                            SizedBox(height: 24),
                            _buildTaskList(),
                          ],
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: _buildEmployeeProgress(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, Nixtio',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'September 13, 2024',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        CircleAvatar(
          backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _StatCard(title: 'Employee', value: '78', progress: 0.15),
        SizedBox(width: 16),
        _StatCard(title: 'Hirings', value: '56', progress: 0.6),
        SizedBox(width: 16),
        _StatCard(title: 'Projects', value: '203', progress: 0.1),
      ],
    );
  }

  Widget _buildCalendar() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'September 2024',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            Table(
              children: [
                TableRow(
                  children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                      .map((day) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(day, textAlign: TextAlign.center),
                          ))
                      .toList(),
                ),
                // Add date rows here
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Schedule',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            _ScheduleItem(
              time: '9:00 AM',
              title: 'Weekly Team Sync',
              subtitle: 'Discuss progress on projects',
            ),
            _ScheduleItem(
              time: '10:00 AM',
              title: 'Onboarding Session',
              subtitle: 'HR Policy Review',
            ),
            _ScheduleItem(
              time: '11:00 AM',
              title: 'Employee Benefits',
              subtitle: 'Introduction for new hires',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeProgress() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Onboarding Progress',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
              ),
              title: Text('Lora Piferson'),
              subtitle: Text('UX/UI Designer'),
              trailing: Chip(label: Text('2/8')),
            ),
            LinearProgressIndicator(value: 0.18),
            SizedBox(height: 16),
            Text('6.1h Week Time', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final double progress;

  const _StatCard({required this.title, required this.value, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey)),
              SizedBox(height: 8),
              Text(value, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600)),
              SizedBox(height: 16),
              LinearProgressIndicator(value: progress),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  final String time;
  final String title;
  final String subtitle;

  const _ScheduleItem({required this.time, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(time, style: TextStyle(color: Colors.grey)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                Text(subtitle, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}