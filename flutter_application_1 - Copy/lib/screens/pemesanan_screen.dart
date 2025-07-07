import 'package:flutter/material.dart';
import 'booking_screen.dart';

class PemesananScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Pemesanan'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Pindah ke halaman menu booking
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookingScreen()),
            );
          },
          child: Text('Lihat Daftar Kamar (Booking)'),
        ),
      ),
    );
  }
}
