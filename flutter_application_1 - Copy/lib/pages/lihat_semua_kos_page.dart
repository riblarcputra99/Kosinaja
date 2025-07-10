import 'package:flutter/material.dart';
import '../model/kos.dart';

class LihatSemuaKosPage extends StatelessWidget {
  final List<Kos> daftarKos;

  const LihatSemuaKosPage({Key? key, required this.daftarKos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Semua Kos")),
      body: ListView.builder(
        itemCount: daftarKos.length,
        itemBuilder: (context, index) {
          final kos = daftarKos[index];
          return Card(
            margin: const EdgeInsets.all(12),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Gambar
                if (kos.gambarUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      kos.gambarUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const SizedBox(
                        height: 180,
                        child: Center(child: Icon(Icons.broken_image, size: 48)),
                      ),
                    ),
                  ),

                // ✅ Informasi kos
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(kos.nama, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(kos.alamat),
                      const SizedBox(height: 4),
                      Text("Telp: ${kos.telepon}"),
                      const SizedBox(height: 4),
                      Text("Kategori: ${kos.kategori}"),
                      Text("Pemilik: ${kos.pemilik}"),
                      const SizedBox(height: 8),

                      // ✅ Harga dan tombol pesan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rp ${kos.harga}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Pesan ${kos.nama} berhasil!')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            child: const Text("Pesan"),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
