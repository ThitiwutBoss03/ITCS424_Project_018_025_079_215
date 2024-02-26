import 'package:flutter/material.dart';

import 'bookmark.dart';
import 'announcement.dart';
import 'profile.dart';
import 'dashboard.dart';

class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Page',
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xFF27346A),
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 50.0,
                ),
                SizedBox(width: 16.0),
              ],
            ),
          ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    SizedBox(width: 8.0),
                    Text('Notifications'),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        // Handle notifications action
                      },
                    ),
                  ],
                ),
              ),
              body: NotificationList(),
              bottomNavigationBar: BottomFunctionBar(),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        NotificationItem(
          title: 'Fee Payments Semester 2/2023',
          icon: Icons.credit_card,
        ),
        NotificationItem(
          title: 'Class Schedule for Semester',
          icon: Icons.calendar_month,
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
      currentIndex: 3,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.black),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark, color: Colors.black),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.announcement, color: Colors.black),
          label: 'Announcements',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications, color: Colors.black),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.black),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // Handle tapping on the navigation bar items
        if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardApp(),
                ),
              );
            }
            else if (index == 1) { // Assuming 'Announcement' is at index 2
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookmarkPage(),
                ),
              );
            }
            else if (index == 2) { // Assuming 'Announcement' is at index 2
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Announcement(),
                ),
              );
            }
            else if (index == 3) { // Assuming 'Announcement' is at index 2
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(),
                ),
              );
            }
            else if (index == 4) { // Assuming 'Announcement' is at index 2
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            }
      },
    );
  }
}