// import 'package:flutter/material.dart';
import 'package:flutter/material.dart' hide VoidCallback;
import 'package:table_calendar/table_calendar.dart';
import 'dart:html';

import 'announcement.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardApp(),
    );
  }
}

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
                    'assets/images/Logo.png', // Replace with your actual logo path
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      Text(
                        'Calendar',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                    // calendar
                      TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                    ), //https://pub.dev/packages/table_calendar
                    //end calendar
                    ],
                  ),
                ),
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
                  title: 'ICT Announcement 1',
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
        currentIndex: 0,
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
            }
            else if (index == 2) { // Assuming 'Announcement' is at index 2
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Announcement(),
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


// // Announcement
// class Announcement extends StatefulWidget {
//   @override
//   _AnnouncementState createState() => _AnnouncementState();
// }

// class _AnnouncementState extends State<Announcement> {
//   int _currentIndex = 0;
//   String selectedCategory = ''; // for category
//   List<String> categories = ['Registration', 'Announcement', 'Internship', 'Activities', 'Bookmark']; // for category

//   TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             color: Color(0xFF27346A),
//             height: 70, // Adjust the height as needed
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Image.asset(
//                     'assets/images/MUICT_Logo.png', // Replace with your actual logo path
//                     fit: BoxFit.contain,
//                     height: 60, // Adjust the height of the logo as needed
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // search
//           Container(
//             // color: Color(0xececec),
//             child: 
//               buildProfileOption('Search', Icons.search, () {
//                 // color: Color(0xececec),
//                 showSearch(context: context, delegate: DataSearch());
//               }),
//           ),
//           // category
//           Container(
//             //chosen of category
//             alignment: Alignment.centerLeft, // Align the content to the left
//             child:
//               const Text('  VIEW BY CATEGORY',
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color.fromARGB(255, 103, 83, 83)),
//               ),
//           ),
//           Container(
//             // category lists
//             height: 50,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: categories.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             selectedCategory = categories[index];
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: selectedCategory == categories[index]
//                               ? const Color.fromARGB(255, 121, 121, 121)
//                               : const Color.fromARGB(255, 228, 228, 228),
//                         ),
//                         child: Text(categories[index],
//                           style: TextStyle(
//                             color: selectedCategory == categories[index]
//                               ? Color.fromARGB(255,255,255,255)
//                               : Color.fromARGB(255, 0, 0, 0),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           // content box
//           Expanded(
//             child: ListView(
//               children: [
//                 // Display multiple boxes
//                 BoxWidget(
//                   imageUrl: '/assets/images/smtg1.jpg',
//                   title: 'ICT Announcement 1',
//                   description: 'ho ho ho ho ho ho ho',
//                   date: 'Feb 2, 2022',
//                   category: 'Registration',
//                 ),
//                 BoxWidget(
//                   imageUrl: '/assets/images/smtg2.jpg',
//                   title: 'ICT Announcement 2',
//                   description: 'ho ho ho ho ho ho ho',
//                   date: 'Feb 2, 2022',
//                   category: 'Registration',
//                 ),
//                 // Add more BoxWidget instances as needed
//               ],
//             ),
//           ),
//         ],
//       ),
//       // Nav bar
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 2,
//         onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//             if (index == 0) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DashboardApp(),
//                 ),
//               );
//             }
//             else if (index == 2) { // Assuming 'Announcement' is at index 2
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Announcement(),
//                 ),
//               );
//             }
//           },
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.black,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bookmark),
//             label: 'Bookmark',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.announcement),
//             label: 'Announcement',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notification',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }

// // icon create
//   Widget buildProfileOption(String title, IconData icon, VoidCallback? onTap,
//       {Color? textColor, Color? iconColor}) {
//     return ListTile(
//       title: Text(
//         title,
//         style: TextStyle(
//           color: textColor,
//         ),
//       ),
//       leading: Icon(
//         icon,
//         color: iconColor,
//       ),
//       onTap: onTap,
//     );
//   }
// }
// // end icon create

// // search bar
// class DataSearch extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // Actions for the app bar
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // Leading icon on the left of the app bar
//     return IconButton(
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // Show results based on the search query
//     return Center(
//       child: Text('Your search results for $query'),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Show suggestions as the user types
//     // You can fetch suggestions from your data source here
//     final List<String> suggestionList = [
//       'Search Result 1',
//       'Search Result 2',
//       'Search Result 3',
//     ];

//     return ListView.builder(
//       itemBuilder: (context, index) => ListTile(
//         title: Text(suggestionList[index]),
//         onTap: () {
//           // Handle suggestion tap
//           showResults(context);
//         },
//       ),
//       itemCount: suggestionList.length,
//     );
//   }
// }
// // end search bar

// // content box
// class BoxWidget extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String description;
//   final String date;
//   final String category;

//   const BoxWidget({
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.category,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Image.network(
//             imageUrl,
//             height: 200,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: Text('Date: $date • Category: $category'),
//           // ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                   Text(
//                   title,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.favorite_border),
//                   onPressed: () {
//                     // Handle favorite button tap
//                   },
//                 ),
//               ]
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(description),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text('Date: $date • Category: $category'),
//           ),
//           // IconButton(
//           //   alignment: Alignment.center,
//           //   icon: Icon(Icons.favorite_border),
//           //   onPressed: () {
//           //     // Handle favorite button tap
//           //   },
//           // ),
//         ],
//       ),
//     );
//   }
// }
// // end content box

// // end of Announcement