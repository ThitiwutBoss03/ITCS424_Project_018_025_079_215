// <head>
// <meta name="google-signin-client_id"
// content="YOUR_CLIENT_ID_HERE" />
// </head>
// OAuth 2.0 Client IDs
// flutter run -d chrome --web-port 5555

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oauth2_client/google_oauth2_client.dart';
import 'package:googleapis/calendar/v3.dart' as GoogleAPI;
import 'package:http/io_client.dart' show IOClient, IOStreamedResponse;
import 'package:http/http.dart' show BaseRequest, Response;
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '205327508421-uchcrj6i0mgj9kcbpd0rj43898gkcgd1.apps.googleusercontent.com',
    // apiKey: 'AIzaSyCfIqv2bu2nXrPCe3pC9VZnPIL_5ghp-Kw',
    scopes: <String>[GoogleAPI.CalendarApi.calendarScope],
  );

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        //getGoogleEventsData();
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<List<GoogleAPI.Event>> getGoogleEventsData() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleAPIClient httpClient =
        GoogleAPIClient(await googleUser!.authHeaders);

    final GoogleAPI.CalendarApi calendarApi = GoogleAPI.CalendarApi(httpClient);
    final GoogleAPI.Events calEvents = await calendarApi.events.list(
      "primary",
    );
    final List<GoogleAPI.Event> appointments = <GoogleAPI.Event>[];
    if (calEvents.items != null) {
      for (int i = 0; i < calEvents.items!.length; i++) {
        final GoogleAPI.Event event = calEvents.items![i];
        if (event.start == null) {
          continue;
        }
        appointments.add(event);
      }
    }

    return appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Calendar'),
      ),
      body: FutureBuilder(
        future: getGoogleEventsData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Stack(
            children: [
              SfCalendar(
                view: CalendarView.month,
                initialDisplayDate: DateTime(2020, 7, 15, 9, 0, 0),
                dataSource: GoogleDataSource(events: snapshot.data),
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment),
              ),
              snapshot.data != null
                  ? Container()
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_googleSignIn.currentUser != null) {
      _googleSignIn.disconnect();
      _googleSignIn.signOut();
    }

    super.dispose();
  }
}

class GoogleDataSource extends CalendarDataSource {
  GoogleDataSource({required List<GoogleAPI.Event>? events}) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    final GoogleAPI.Event event = appointments![index];
    return event.start?.date ?? event.start!.dateTime!.toLocal();
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].start.date != null;
  }

  @override
  DateTime getEndTime(int index) {
    final GoogleAPI.Event event = appointments![index];
    return event.endTimeUnspecified != null && event.endTimeUnspecified!
        ? (event.start?.date ?? event.start!.dateTime!.toLocal())
        : (event.end?.date != null
            ? event.end!.date!.add(const Duration(days: -1))
            : event.end!.dateTime!.toLocal());
  }

  @override
  String getLocation(int index) {
    return appointments![index].location ?? '';
  }

  @override
  String getNotes(int index) {
    return appointments![index].description ?? '';
  }

  @override
  String getSubject(int index) {
    final GoogleAPI.Event event = appointments![index];
    return event.summary == null || event.summary!.isEmpty
        ? 'No Title'
        : event.summary!;
  }
}

class GoogleAPIClient extends IOClient {
  final Map<String, String> _headers;

  GoogleAPIClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) =>
      super.head(url,
          headers: (headers != null ? (headers..addAll(_headers)) : headers));
}

// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/calendar/v3.dart' as GoogleAPI;
// import 'package:oauth2_client/google_oauth2_client.dart';
// import 'package:http/io_client.dart' show IOClient, IOStreamedResponse;
// import 'package:http/http.dart' show BaseRequest, Response;
// import 'package:syncfusion_flutter_calendar/calendar.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//     clientId: '205327508421-uchcrj6i0mgj9kcbpd0rj43898gkcgd1.apps.googleusercontent.com',
//     scopes: <String>[
//       'email',
//       GoogleAPI.CalendarApi.calendarScope,
//     ],
//   );

//   GoogleSignInAccount? _currentUser;

//   @override
//   void initState() {
//     super.initState();
//     _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
//       setState(() {
//         _currentUser = account;
//       });
//     });
//     _googleSignIn.signInSilently().catchError((error) {
//       print('Error signing in silently: $error');
//     });
//   }

//   Future<void> _handleSignIn() async {
//     try {
//       await _googleSignIn.signIn();
//     } catch (error) {
//       print('Error signing in: $error');
//     }
//   }


//   Future<List<GoogleAPI.Event>> getGoogleEventsData() async {
//     try {
//       if (_currentUser == null) {
//         throw Exception('User is not signed in.');
//       }

//       final GoogleAPIClient httpClient =
//           GoogleAPIClient(await _currentUser!.authHeaders);

//       final GoogleAPI.CalendarApi calendarApi =
//           GoogleAPI.CalendarApi(httpClient);
//       final GoogleAPI.Events calEvents = await calendarApi.events.list(
//         "primary",
//       );

//       return calEvents.items ?? [];
//     } catch (e) {
//       print('Error fetching events: $e');
//       return []; // Return an empty list in case of error
//     }
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Event Calendar'),
//       ),
//       body: FutureBuilder<List<GoogleAPI.Event>>(
//         future: getGoogleEventsData(),
//         builder: (BuildContext context,
//             AsyncSnapshot<List<GoogleAPI.Event>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return _currentUser != null
//                 ? SfCalendar(
//                     view: CalendarView.month,
//                     initialDisplayDate: DateTime(2020, 7, 15, 9, 0, 0),
//                     dataSource: GoogleDataSource(events: snapshot.data),
//                     monthViewSettings: const MonthViewSettings(
//                         appointmentDisplayMode:
//                             MonthAppointmentDisplayMode.appointment),
//                   )
//                 : Center(
//                     child: ElevatedButton(
//                       onPressed: _handleSignIn,
//                       child: Text('Sign in with Google'),
//                     ),
//                   );
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     if (_googleSignIn.currentUser != null) {
//       _googleSignIn.disconnect();
//     }
//     super.dispose();
//   }
// }

// class GoogleDataSource extends CalendarDataSource {
//   GoogleDataSource({required List<GoogleAPI.Event>? events}) {
//     appointments = events;
//   }

//   @override
//   DateTime getStartTime(int index) {
//     final GoogleAPI.Event event = appointments![index];
//     return event.start?.date ?? event.start!.dateTime!.toLocal();
//   }

//   @override
//   bool isAllDay(int index) {
//     return appointments![index].start.date != null;
//   }

//   @override
//   DateTime getEndTime(int index) {
//     final GoogleAPI.Event event = appointments![index];
//     return event.endTimeUnspecified != null && event.endTimeUnspecified!
//         ? (event.start?.date ?? event.start!.dateTime!.toLocal())
//         : (event.end?.date != null
//             ? event.end!.date!.add(const Duration(days: -1))
//             : event.end!.dateTime!.toLocal());
//   }

//   @override
//   String getLocation(int index) {
//     return appointments![index].location ?? '';
//   }

//   @override
//   String getNotes(int index) {
//     return appointments![index].description ?? '';
//   }

//   @override
//   String getSubject(int index) {
//     final GoogleAPI.Event event = appointments![index];
//     return event.summary == null || event.summary!.isEmpty
//         ? 'No Title'
//         : event.summary!;
//   }
// }

// class GoogleAPIClient extends IOClient {
//   final Map<String, String> _headers;

//   GoogleAPIClient(this._headers) : super();

//   @override
//   Future<IOStreamedResponse> send(BaseRequest request) async {
//     final Response response = (await super.send(request..headers.addAll(_headers))) as Response;

//     // Convert Response body to Stream<List<int>>
//     final stream = Stream<List<int>>.fromIterable([response.bodyBytes]);

//     // Create and return IOStreamedResponse
//     return IOStreamedResponse(
//       stream,
//       response.statusCode,
//       contentLength: response.contentLength,
//       request: response.request,
//       headers: response.headers,
//       reasonPhrase: response.reasonPhrase,
//     );
//   }

//   @override
//   Future<Response> head(Uri url, {Map<String, String>? headers}) =>
//       super.head(url, headers: (headers != null ? (headers..addAll(_headers)) : headers));
// }
