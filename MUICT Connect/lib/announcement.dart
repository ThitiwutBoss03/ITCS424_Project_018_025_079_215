import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

import 'dashboard.dart';
import 'profile.dart';
import 'bookmark.dart';
import 'notification.dart';
import 'create_post.dart';
import 'manage_post.dart';

// Announcement
class Announcement extends StatefulWidget {
  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  int _currentIndex = 0;
  String selectedCategory = ''; // for category
  List<String> categories = [
    'registration',
    'announcement',
    'internship',
    'activities',
  ]; // for category
  List<DocumentSnapshot> allDocuments = [];
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
              ],
            ),
          ),
          // Button to create a post
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), // Adjust the border radius as needed
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManagePost()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color(0xFF27346A), // Set the background color of the button
                elevation: 0, // No elevation
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Post Management',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ),
          ),

          // category
          Container(
            //chosen of category
            alignment: Alignment.centerLeft, // Align the content to the left
            child: const Text(
              '  VIEW BY CATEGORY',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 103, 83, 83)),
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
                            if (selectedCategory == categories[index]) {
                              // If the same category is clicked again, undo the filter
                              selectedCategory = '';
                            } else {
                              selectedCategory = categories[index];
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedCategory == categories[index]
                              ? const Color.fromARGB(255, 121, 121, 121)
                              : const Color.fromARGB(255, 228, 228, 228),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: selectedCategory == categories[index]
                                ? Color.fromARGB(255, 255, 255, 255)
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Announcement')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No data available'));
                }
                allDocuments = snapshot.data!.docs;
                final filteredDocuments = selectedCategory.isEmpty
                    ? allDocuments
                    : allDocuments
                        .where((doc) => doc['category'] == selectedCategory)
                        .toList();
                return ListView.builder(
                  itemCount: filteredDocuments.length,
                  itemBuilder: (context, index) {
                    final document = filteredDocuments[index];
                    final imageUrl = document['imageURL'] ?? '';
                    final title = document['title'] ?? '';
                    final description = document['description'] ?? '';
                    final date = document['createdDate']?.toString() ?? '';
                    final category = document['category'] ?? '';
                    final isBookmarked = document['bookmark'] ?? false;

                    return BoxWidget(
                      imageUrl: imageUrl,
                      title: title,
                      description: description,
                      date: date,
                      category: category,
                      isBookmarked: isBookmarked,
                      onBookmarkTap: () {
                        // Toggle the bookmark status
                        FirebaseFirestore.instance.collection('Announcement').doc(document.id).update({
                          'bookmark': !isBookmarked,
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Nav bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookmarkPage(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Announcement(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationPage(),
              ),
            );
          } else if (index == 4) {
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
}

// content box
class BoxWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String date;
  final String category;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;

  const BoxWidget({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.isBookmarked,
    required this.onBookmarkTap,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isBookmarked ? Icons.favorite : Icons.favorite_border,
                    color: isBookmarked ? Colors.red : null,
                  ),
                  onPressed: onBookmarkTap,
                ),
              ],
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
        ],
      ),
    );
  }
}
