import 'package:flutter/material.dart';

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
      bottomNavigationBar: BottomFunctionBar(),
    );
  }
}