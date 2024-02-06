import 'package:flutter/material.dart';

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
  int _currentIndex = 0;
  String selectedCategory = ''; // for category
  List<String> categories = ['Registration', 'Announcement', 'Internship', 'Activities', 'Bookmark']; // for category

  TextEditingController _searchController = TextEditingController();

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
          // search
          Container(
            // color: Color(0xececec),
            child: 
              buildProfileOption('Search', Icons.search, () {
                // color: Color(0xececec),
                showSearch(context: context, delegate: DataSearch());
              }),
          ),
          // category
          Container(
            //chosen of category
            alignment: Alignment.centerLeft, // Align the content to the left
            child:
              const Text('  VIEW BY CATEGORY',
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color.fromARGB(255, 103, 83, 83)),
              ),
          ),
          Container(
            // category lists
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedCategory = categories[index];
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: selectedCategory == categories[index]
                              ? const Color.fromARGB(255, 121, 121, 121)
                              : const Color.fromARGB(255, 228, 228, 228),
                        ),
                        child: Text(categories[index],
                          style: TextStyle(
                            color: selectedCategory == categories[index]
                              ? Color.fromARGB(255,255,255,255)
                              : Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // content box
          Expanded(
            child: ListView(
              children: [
                // Display multiple boxes
                BoxWidget(
                  imageUrl: '/assets/images/smtg1.jpg',
                  title: 'ICT Annoucement 1',
                  description: 'ho ho ho ho ho ho ho',
                  date: 'Feb 2, 2022',
                  category: 'Registration',
                ),
                BoxWidget(
                  imageUrl: '/assets/images/smtg2.jpg',
                  title: 'ICT Annoucement 2',
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
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
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

// icon create
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
      onTap: onTap,
    );
  }
}
// end icon create

// search bar
class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions for the app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show results based on the search query
    return Center(
      child: Text('Your search results for $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions as the user types
    // You can fetch suggestions from your data source here
    final List<String> suggestionList = [
      'Search Result 1',
      'Search Result 2',
      'Search Result 3',
    ];

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestionList[index]),
        onTap: () {
          // Handle suggestion tap
          showResults(context);
        },
      ),
      itemCount: suggestionList.length,
    );
  }
}
// end search bar

// content box
class BoxWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String date;
  final String category;

  const BoxWidget({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Date: $date • Category: $category'),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // Handle favorite button tap
                  },
                ),
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Date: $date • Category: $category'),
          ),
          // IconButton(
          //   alignment: Alignment.center,
          //   icon: Icon(Icons.favorite_border),
          //   onPressed: () {
          //     // Handle favorite button tap
          //   },
          // ),
        ],
      ),
    );
  }
}
// end content box