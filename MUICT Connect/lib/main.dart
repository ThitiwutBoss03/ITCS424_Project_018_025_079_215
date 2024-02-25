// import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide VoidCallback;
import 'package:flutter_application_1/firebase_options.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'announcement.dart';
import 'profile.dart';
import 'bookmark.dart';
import 'notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

class WeatherBox extends StatelessWidget {
  final dynamic weatherData;

  WeatherBox({required this.weatherData});

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  // Function to map weather condition code to icon URL
  String getWeatherIcon(String conditionCode) {
    return "https://openweathermap.org/img/wn/$conditionCode@2x.png";
  }

  @override
  Widget build(BuildContext context) {
    if (weatherData != null) {
      // Extract and display relevant weather information
      final temperatureKelvin = weatherData['main']['temp'];
      final temperatureCelsius = kelvinToCelsius(temperatureKelvin);
      final description = weatherData['weather'][0]['description'];
      final conditionCode = weatherData['weather'][0]['icon'];

      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weather Today',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Temperature: ${temperatureCelsius.toStringAsFixed(2)}°C',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Text(
                  'Description: ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Image.network(
                  getWeatherIcon(conditionCode),
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      // Placeholder if weather data is not available
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          'Weather data not available',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      );
    }
  }
}

class _DashboardState extends State<DashboardApp> {
  int _currentIndex = 0;
  DateTime today = DateTime.now();

  // Weather data variable
  dynamic weatherData;

  @override
  void initState() {
    super.initState();
    getData(); // Move the data fetching to initState
  }


  getData() async {
    final apiKey = 'a1e8ca175935779fb295df7f6eff8088';
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=13.792914&lon=100.324200&appid=86fb463f2dc2a3f8797be6018610d38a");
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      // Case 1: Successful response (HTTP 200)
      print("Data fetched successfully:");
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else if (response.statusCode == 404) {
      // Case 2: Resource not found (HTTP 404)
      print("Resource not found");
    } else if (response.statusCode == 401) {
      // Case 3: Unauthorized access (HTTP 401)
      print("Unauthorized access");
    } else if (response.statusCode == 500) {
      // Case 4: Internal server error (HTTP 500)
      print("Internal server error");
    } else {
      // Case 5: Other status codes
      print("Request failed with status code ${response.statusCode}");
    }
  }
  

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();

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
          // content box
          Expanded(
            child: ListView(
              children: [
                // margin: new EdgeInsets.symmetric(horizontal: 20.0),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Column(
                    children: [
                      Text(
                        'Calendar',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      // calendar
                      TableCalendar(
                        selectedDayPredicate: (day) => isSameDay(day, today),
                        headerStyle: HeaderStyle(
                            formatButtonVisible: false, titleCentered: true),
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        onDaySelected: _onDaySelected,
                      ), //https://pub.dev/packages/table_calendar
                      //end calendar
                    ],
                  ),
                ),
                WeatherBox(weatherData: weatherData),
                // Display multiple boxes
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'Activities',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                BoxWidgetWithImageOnLeft(
                  imageUrl: 'assets/dash.jpg',
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