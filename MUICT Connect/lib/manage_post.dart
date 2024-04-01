import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'create_post.dart';
import 'dashboard.dart';
import 'profile.dart';
import 'bookmark.dart';
import 'notification.dart';
import 'announcement.dart';

// ManagePost
class ManagePost extends StatefulWidget {
  @override
  _ManagePostState createState() => _ManagePostState();
}

class _ManagePostState extends State<ManagePost> {
  int _currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: Column(
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
            AppBar(
              automaticallyImplyLeading: true,
              title: Text('Post Management'),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Announcement').snapshots(),
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
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final document = snapshot.data!.docs[index];
              final imageUrl = document['imageURL'] ?? '';
              final title = document['title'] ?? '';
              final description = document['description'] ?? '';
              final date = document['createdDate']?.toString() ?? '';
              final category = document['category'] ?? '';
              final eventId = document['eventID'] ?? '';

              return PostWidget(
                imageUrl: imageUrl,
                title: title,
                description: description,
                date: date,
                category: category,
                eventID: eventId, // Pass the eventID to PostWidget
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage()),
          );
        },
        child: Icon(Icons.add),
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
}

// PostWidget
class PostWidget extends StatelessWidget {
  final int eventID; // Document ID of the post
  final String imageUrl;
  final String title;
  final String description;
  final String date;
  final String category;

  const PostWidget({
    required this.eventID,
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
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Delete Post"),
                          content: Text(
                              "Are you sure you want to delete this post?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                // Delete the document from Firestore based on eventID
                                FirebaseFirestore.instance
                                    .collection('Announcement')
                                    .where('eventID', isEqualTo: eventID)
                                    .get()
                                    .then((querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    doc.reference.delete().then((value) {
                                      // Document successfully deleted
                                      print("Post deleted successfully");
                                    }).catchError((error) {
                                      // An error occurred while deleting the document
                                      print("Error deleting post: $error");
                                    });
                                  });
                                });
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
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
