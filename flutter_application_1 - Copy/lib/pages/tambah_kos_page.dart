import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Kos {
  final String nama;
  final String alamat;
  final String telepon;
  final String gambar;

  Kos(this.nama, this.alamat, this.telepon, this.gambar);

  Map<String, dynamic> toJson() => {
    'nama': nama,
    'alamat': alamat,
    'telepon': telepon,
    'gambar': gambar,
  };

  factory Kos.fromJson(Map<String, dynamic> json) {
    return Kos(
      json['nama'],
      json['alamat'],
      json['telepon'],
      json['gambar'] ?? '',
    );
  }
}

class TambahKosPage extends StatefulWidget {
  final Function(Kos) onKosDitambahkan;
  const TambahKosPage({super.key, required this.onKosDitambahkan});

  @override
  State<TambahKosPage> createState() => _TambahKosPageState();
}

class _TambahKosPageState extends State<TambahKosPage> {
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _teleponController = TextEditingController();
  final _gambarController = TextEditingController();

  void _simpanKos() async {
    final nama = _namaController.text.trim();
    final alamat = _alamatController.text.trim();
    final telepon = _teleponController.text.trim();
    final gambar = _gambarController.text.trim();

    if (nama.isEmpty || alamat.isEmpty || telepon.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua field wajib diisi (kecuali gambar)'),
        ),
      );
      return;
    }

    final kosBaru = Kos(nama, alamat, telepon, gambar);
    widget.onKosDitambahkan(kosBaru);

    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getStringList('kos_list') ?? [];

    final jsonData = kosBaru.toJson();
    existingData.add(jsonEncode(jsonData));

    await prefs.setStringList('kos_list', existingData);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Kos berhasil disimpan')));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Kos")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Form Tambah Kos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Kos",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: "Alamat",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _teleponController,
                decoration: const InputDecoration(
                  labelText: "No. Telepon",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _gambarController,
                decoration: const InputDecoration(
                  labelText: "URL Gambar (Opsional)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _simpanKos,
                  child: const Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
