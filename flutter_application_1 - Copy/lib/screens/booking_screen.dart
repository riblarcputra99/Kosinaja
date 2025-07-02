import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Nama')),
            TextField(decoration: InputDecoration(labelText: 'Tanggal')),
            TextField(decoration: InputDecoration(labelText: 'Tipe Kamar')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Booking Berhasil!')),
                );
              },
              child: const Text('Kirim Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
