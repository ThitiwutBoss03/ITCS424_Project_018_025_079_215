import 'package:flutter/material.dart';

import 'edit_profile.dart';
import 'announcement.dart';
import 'dashboard.dart';
import 'bookmark.dart';
import 'notification.dart';
import 'aboutus.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 4; // Setting current page to Profile Page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xFF27346A),
            height: 70, // Adjust the height as needed
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/Logo.png', // Replace with your actual logo path
                    fit: BoxFit.contain,
                    height: 60, // Adjust the height of the logo as needed
                  ),
                ),
                Expanded(
                  child:
                      Container(), // Empty container to expand and cover the width
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, top: 16, bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/profile_picture.png'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Somchai Jaidee',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'staff@gmail.com',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 30),
                    buildProfileOption('Edit Profile', Icons.edit, () {
                      // Add navigation or functionality for Edit Profile
                    }),
                    buildProfileOption('Notifications', Icons.notifications,
                        () {
                      // Add navigation or functionality for Notifications
                    }),
                    buildProfileOption('About', Icons.info, () {
                      // Add navigation or functionality for About
                    }),
                    buildProfileOption('Security', Icons.security, () {
                      // Add navigation or functionality for Security
                    }),
                    buildProfileOption('Language', Icons.language, () {
                      // Add navigation or functionality for Language
                    }),
                    buildProfileOption('Sign Out', Icons.exit_to_app, () {
                      // Add functionality for Sign Out
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    }, textColor: Colors.red, iconColor: Colors.red),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardApp(),
              ),
            );
          } else if (index == 1) {
            // Assuming 'Announcement' is at index 2
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookmarkPage(),
              ),
            );
          } else if (index == 2) {
            // Assuming 'Announcement' is at index 2
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Announcement(),
              ),
            );
          } else if (index == 3) {
            // Assuming 'Announcement' is at index 2
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationPage(),
              ),
            );
          } else if (index == 4) {
            // Assuming 'Announcement' is at index 2
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          }
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildProfileOption(String title, IconData icon, VoidCallback? onTap,
      {Color? textColor, Color? iconColor}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      leading: Icon(
        icon,
        color: iconColor,
      ),
      onTap: onTap != null
          ? () {
              if (title == 'Edit Profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      name: 'Somchai Jaidee', // Pass name from the profile
                      email: 'staff@gmail.com', // Pass email from the profile
                      contactNumber:
                          '0812345678', // Pass contact number from the profile
                    ),
                  ),
                );
              } else if (title == 'About') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUsPage(),
                  ),
                );
              } else if (title == 'Notifications') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationPage(),
                  ),
                );
              } else {
                onTap();
              }
            }
          : null,
    );
  }
}
