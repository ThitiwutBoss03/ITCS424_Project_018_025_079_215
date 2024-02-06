import 'package:flutter/material.dart';

void main() {
  runApp(NotificationPage());
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Container(
              color: Color(0xFF27346A), // Set the background color to blue
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Place the logo on the left side
                  Image.asset(
                    'assets/logo.png', // Replace with your logo image file
                    height: 50.0, // Adjust the height as needed
                  ),
                  SizedBox(width: 16.0), // Add spacing between logo and text
                ],
              ),
            ),
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          // Handle back action
                        },
                      ),
                      SizedBox(width: 8.0), // Add spacing
                      Text('Notifications'),
                    ],
                  ),
                ),
                body: NotificationList(),
                bottomNavigationBar: BottomFunctionBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Notification Items
        NotificationItem(
          title: 'Fee Payments Semester 2/2023',
          icon: Icons.credit_card,
        ),
        NotificationItem(
          title: 'Class Schedule for Semester',
          icon: Icons.calendar_today,
        ),
        NotificationItem(
          title: 'Internship (Japan: Round 3)',
          icon: Icons.airplanemode_active,
        ),
        NotificationItem(
          title: 'Class Attendance Regulation and Submission Guideline',
          icon: Icons.book,
        ),
        NotificationItem(
          title: 'ICT Mahidol Job & Education Fair #15',
          icon: Icons.shopping_bag,
        ),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final IconData icon;

  NotificationItem({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}

class BottomFunctionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black), // Black color
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today, color: Colors.black), // Black color
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.announcement, color: Colors.black), // Black color
          label: 'Announcements',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications, color: Colors.black), // Black color
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.black), // Black color
          label: 'Profile',
        ),
      ],
    );
  }
}
