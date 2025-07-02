import 'package:flutter/material.dart';
import '../utils/dummy_data.dart';
import '../widgets/kos_card.dart';
import 'order_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Kos')),
      body: ListView.builder(
        itemCount: dummyKosList.length,
        itemBuilder: (context, index) {
          final kos = dummyKosList[index];
          return KosCard(
            kos: kos,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => OrderScreen(kos: kos)),
              );
            },
          );
        },
      ),
    );
  }
}
