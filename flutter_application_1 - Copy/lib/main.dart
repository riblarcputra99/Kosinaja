import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(KOSinAjaApp());
}

class KOSinAjaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KOSinAja',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
