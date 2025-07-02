import 'package:flutter/material.dart';
import '../models/kos_model.dart';

class OrderScreen extends StatelessWidget {
  final KosModel kos;

  const OrderScreen({required this.kos, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesan ${kos.nama}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(kos.gambarUrl),
            const SizedBox(height: 12),
            Text(kos.deskripsi, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text('Harga: Rp ${kos.hargaPerBulan}',
                style: const TextStyle(fontSize: 20)),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.shopping_cart),
              label: const Text('Pesan Sekarang'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berhasil dipesan!')),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
