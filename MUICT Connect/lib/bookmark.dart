import 'package:flutter/material.dart';

import 'notification.dart';
import 'announcement.dart';
import 'profile.dart';
import 'dashboard.dart';

class BookmarkPage extends StatelessWidget {
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
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Handle back action
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 16.0),
                Text('Bookmarks'),
                Spacer(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/Bookmark.png',
                  height: 300.0,
                ),
                SizedBox(width: 20.0),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: 1,
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
    ),
    );
  }
}