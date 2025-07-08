import 'package:flutter/material.dart';

class LihatSemuaKosPage extends StatelessWidget {
  const LihatSemuaKosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lihat Semua Kos")),
      body: const Center(
        child: Text(
          "Daftar kos akan ditampilkan di sini",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
