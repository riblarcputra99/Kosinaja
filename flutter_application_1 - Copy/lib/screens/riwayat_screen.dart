import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiwayatScreen extends StatefulWidget {
  @override
  _RiwayatScreenState createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  List<String> riwayat = [];

  @override
  void initState() {
    super.initState();
    _loadRiwayat();
  }

  Future<void> _loadRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      riwayat = prefs.getStringList('riwayat') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Booking')),
      body: ListView.builder(
        itemCount: riwayat.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(riwayat[index]),
          );
        },
      ),
    );
  }
}
