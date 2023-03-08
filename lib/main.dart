import 'package:flutter/material.dart';
import 'package:wallpaper_app/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.white),
            foregroundColor: Colors.black),
      ),
      home: const HomePage(),
    );
  }
}
