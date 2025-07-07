import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingScreen extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const BookingScreen({Key? key, required this.hotel}) : super(key: key);

  Future<void> _simpanRiwayat() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList('riwayat') ?? [];

    final newRiwayat =
        '${hotel['name']} - ${hotel['location']} - Rp ${hotel['price']}';
    existing.add(newRiwayat);

    await prefs.setStringList('riwayat', existing);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${hotel['name']}', style: TextStyle(fontSize: 18)),
            Text('Lokasi: ${hotel['location']}',
                style: TextStyle(fontSize: 18)),
            Text('Harga: Rp ${hotel['price']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _simpanRiwayat();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Booking berhasil disimpan!')),
                );
              },
              child: Text('Booking Sekarang'),
            )
          ],
        ),
      ),
    );
  }
}
