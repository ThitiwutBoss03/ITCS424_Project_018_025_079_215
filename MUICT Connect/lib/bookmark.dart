import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

import 'announcement.dart';
import 'profile.dart';
import 'dashboard.dart';
import 'notification.dart';

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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Announcement')
                  .where('bookmark', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No bookmarked posts'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[index];
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
            label: 'bookmark',
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
