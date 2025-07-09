import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Kos {
  final String nama;
  final String alamat;
  final String telepon;
  final String gambarUrl;

  Kos(this.nama, this.alamat, this.telepon, this.gambarUrl);

  Map<String, dynamic> toJson() => {
    'nama': nama,
    'alamat': alamat,
    'telepon': telepon,
    'gambarUrl': gambarUrl,
  };

  factory Kos.fromJson(Map<String, dynamic> json) => Kos(
    json['nama'],
    json['alamat'],
    json['telepon'],
    json['gambarUrl'] ?? '',
  );
}

class LihatSemuaKosPage extends StatefulWidget {
  const LihatSemuaKosPage({Key? key}) : super(key: key);

  @override
  State<LihatSemuaKosPage> createState() => _LihatSemuaKosPageState();
}

class _LihatSemuaKosPageState extends State<LihatSemuaKosPage> {
  List<Kos> daftarKos = [];

  @override
  void initState() {
    super.initState();
    _loadKos();
  }

  Future<void> _loadKos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('kos_list');
    if (jsonData != null) {
      final data = jsonDecode(jsonData) as List;
      setState(() {
        daftarKos = data.map((e) => Kos.fromJson(e)).toList();
      });
    }
  }

  Future<void> _saveKos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(daftarKos.map((e) => e.toJson()).toList());
    await prefs.setString('kos_list', jsonData);
  }

  void _hapusKos(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Hapus Kos"),
        content: Text("Yakin ingin menghapus kos ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              setState(() => daftarKos.removeAt(index));
              await _saveKos();
              Navigator.pop(context);
            },
            child: Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editKos(int index) {
    final kos = daftarKos[index];
    final namaController = TextEditingController(text: kos.nama);
    final alamatController = TextEditingController(text: kos.alamat);
    final teleponController = TextEditingController(text: kos.telepon);
    final gambarController = TextEditingController(text: kos.gambarUrl);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit Kos'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
              ),
              TextField(
                controller: teleponController,
                decoration: InputDecoration(labelText: 'Telepon'),
              ),
              TextField(
                controller: gambarController,
                decoration: InputDecoration(labelText: 'URL Gambar'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (namaController.text.trim().isEmpty ||
                  alamatController.text.trim().isEmpty ||
                  teleponController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Nama, alamat, dan telepon tidak boleh kosong',
                    ),
                  ),
                );
                return;
              }

              setState(() {
                daftarKos[index] = Kos(
                  namaController.text.trim(),
                  alamatController.text.trim(),
                  teleponController.text.trim(),
                  gambarController.text.trim(),
                );
              });
              _saveKos();
              Navigator.pop(context);
            },
            child: Text('Simpan'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lihat Semua Kos')),
      body: ListView.builder(
        itemCount: daftarKos.length,
        itemBuilder: (context, index) {
          final kos = daftarKos[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Icon(Icons.home, size: 40, color: Colors.blueGrey),
              title: Text(
                kos.nama,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(kos.alamat), Text('Telp: ${kos.telepon}')],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editKos(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _hapusKos(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
