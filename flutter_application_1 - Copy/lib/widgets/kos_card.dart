import 'package:flutter/material.dart';
import '../models/kos_model.dart';

class KosCard extends StatelessWidget {
  final KosModel kos;
  final VoidCallback onTap;

  const KosCard({
    required this.kos,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kos.tersedia ? Colors.white : Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: kos.tersedia ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                kos.gambarUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kos.nama,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    kos.lokasi,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${kos.hargaPerBulan}/bulan',
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (!kos.tersedia)
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        'Kamar Penuh',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
