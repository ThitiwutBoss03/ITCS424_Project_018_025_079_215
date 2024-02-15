import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

// Dashboard
class DashboardApp extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardApp> {
  int _currentIndex = 0;
  
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
                    'assets/images/MUICT_Logo.png', // Replace with your actual logo path
                    fit: BoxFit.contain,
                    height: 60, // Adjust the height of the logo as needed
                  ),
                ),
              ],
            ),
          ),
          // content box
          Expanded(
            child: ListView(
              children: [
                // margin: new EdgeInsets.symmetric(horizontal: 20.0),
                // calendar
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                ), //https://pub.dev/packages/table_calendar
                //end calendar
                // Display multiple boxes
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'Activities',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                BoxWidgetWithImageOnLeft(
                  imageUrl: 'assets/images/dash.jpg',
                  title: 'ICT Annoucement 1',
                  description: 'ho ho ho ho ho ho ho',
                  date: 'Feb 2, 2022',
                  category: 'Registration',
                ),
                // Add more BoxWidget instances as needed
              ],
            ),
          ),
        ],
      ),
      // Nav bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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
}

// Bow on the left
class BoxWidgetWithImageOnLeft extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String date;
  final String category;

  BoxWidgetWithImageOnLeft({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image on the left
          Image.asset(
            imageUrl,
            width: 250,
            height: 350,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10), // Add some space between the image and text
          // Text and other details on the right
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                Text(
                  'Date: $date',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Category: $category',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// end Box on the left