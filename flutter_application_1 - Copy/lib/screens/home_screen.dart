import 'package:flutter/material.dart';
import 'booking_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> hotels = [
    {
      'name': 'Kos A',
      'location': 'Jakarta',
      'price': 1000000,
    },
    {
      'name': 'Kos B',
      'location': 'Bandung',
      'price': 850000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kos In Aja')),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return ListTile(
            title: Text(hotel['name']),
            subtitle: Text(hotel['location']),
            trailing: Text('Rp ${hotel['price']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingScreen(hotel: hotel),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
