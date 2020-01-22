import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'pages/pages.dart';
import 'services/services.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],

      routes: {
        '/': (context) => LoginPage(),
        '/topics': (context) => TopicsPage(),
        '/profile': (context) => ProfilePage(),
        '/about': (context) => AboutPage(),
      },

      theme: ThemeData(
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.black87,
        ),
        brightness: Brightness.dark,
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 17),
          body2: TextStyle(fontSize: 15),
          button: TextStyle(fontWeight: FontWeight.bold),
          headline: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          subhead: TextStyle(color: Colors.red),
        ),
        buttonTheme: ButtonThemeData(),
      ),
    );
  }
}
