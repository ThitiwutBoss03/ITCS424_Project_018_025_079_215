import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(MyApp());
}

enum Founder {
  RamitaDeeprom,
  ThitiwutHarn,
  BuritSihabut,
  PongsakornKongkaewrasamee
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AboutUsPage(),
    );
  }
}

class AboutUsPage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<AboutUsPage> {
  int _currentIndex = 0;
  Founder currentFounder = Founder.RamitaDeeprom;

  void updateInfo() {
    setState(() {
      switch (currentFounder) {
        case Founder.RamitaDeeprom:
          currentFounder = Founder.ThitiwutHarn;
          break;
        case Founder.ThitiwutHarn:
          currentFounder = Founder.BuritSihabut;
          break;
        case Founder.BuritSihabut:
          currentFounder = Founder.PongsakornKongkaewrasamee;
          break;
        case Founder.PongsakornKongkaewrasamee:
          currentFounder = Founder.RamitaDeeprom;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String name;
    String linkedInUrl;

    switch (currentFounder) {
      case Founder.RamitaDeeprom:
        name = 'Ramita Deeprom';
        linkedInUrl = 'https://www.linkedin.com/in/ramita-deeprom/';
        break;
      case Founder.ThitiwutHarn:
        name = 'Thitiwut Harnphatcharapanukorn';
        linkedInUrl = 'https://www.linkedin.com/in/thitiwut-harn';
        break;
      case Founder.BuritSihabut:
        name = 'Burit Sihabut';
        linkedInUrl = 'https://www.linkedin.com/in/burit-sihabut-best/';
        break;
      case Founder.PongsakornKongkaewrasamee:
        name = 'Pongsakorn Kongkaewrasamee';
        linkedInUrl =
            'https://th.linkedin.com/in/pongsakorn-kongkaewrasamee-32398a267';
        break;
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: const Color(0xFF27346A),
            height: 70,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/Logo.png',
                    fit: BoxFit.contain,
                    height: 60,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
            alignment: Alignment.centerLeft,
            child: const Text(
              'About Us',
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
                    const Text(
                      'Founders',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentFounder = Founder.RamitaDeeprom;
                              });
                            },
                            child: const Icon(
                              Icons.arrow_left,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/profile_picture.png'),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: updateInfo,
                            child: const Icon(
                              Icons.arrow_right,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      name,
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.link,
                            size: 24,
                          ),
                          InkWell(
                            onTap: () async {
                              if (await canLaunchUrlString(linkedInUrl)) {
                                await launchUrlString(linkedInUrl);
                              }
                            },
                            child: Text(
                              currentFounder == Founder.RamitaDeeprom
                                  ? 'Ramita Deeprom'
                                  : currentFounder == Founder.ThitiwutHarn
                                      ? 'Thitiwut Harn'
                                      : currentFounder == Founder.BuritSihabut
                                          ? 'Burit Sihabut'
                                          : 'Pongsakorn Kongkaewrasamee',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const Text(
                      'MUICT Connect addresses the communication gap within the Faculty of ICT by providing a centralized platform for academic and extracurricular announcements. The aim is to keep ICT students informed about important events, academic updates, and opportunities to enhance their overall university experience.',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
        },
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        items: const [
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
}
