import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LihatSemuaKosPage extends StatefulWidget {
  const LihatSemuaKosPage({super.key});

  @override
  State<LihatSemuaKosPage> createState() => _LihatSemuaKosPageState();
}

class _LihatSemuaKosPageState extends State<LihatSemuaKosPage> {
  List<Map<String, dynamic>> daftarKos = [];

  @override
  void initState() {
    super.initState();
    _muatDataKos();
  }

  Future<void> _muatDataKos() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dataString = prefs.getStringList('kos_list') ?? [];

    final List<Map<String, dynamic>> dataKos = dataString.map((e) {
      return json.decode(e) as Map<String, dynamic>;
    }).toList();

    setState(() {
      daftarKos = dataKos;
    });
  }

  Future<void> _hapusKos(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dataString = prefs.getStringList('kos_list') ?? [];
    dataString.removeAt(index);
    await prefs.setStringList('kos_list', dataString);
    _muatDataKos();
  }

  void _editKosDialog(int index) {
    final namaController = TextEditingController(
      text: daftarKos[index]['nama'],
    );
    final alamatController = TextEditingController(
      text: daftarKos[index]['alamat'],
    );
    final teleponController = TextEditingController(
      text: daftarKos[index]['telepon'],
    );
    final gambarController = TextEditingController(
      text: daftarKos[index]['gambar'] ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Kos"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: 'Nama'),
                ),
                TextField(
                  controller: alamatController,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                ),
                TextField(
                  controller: teleponController,
                  decoration: const InputDecoration(labelText: 'Telepon'),
                ),
                TextField(
                  controller: gambarController,
                  decoration: const InputDecoration(labelText: 'URL Gambar'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              child: const Text("Simpan"),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final List<String> dataString =
                    prefs.getStringList('kos_list') ?? [];

                final updatedKos = {
                  'nama': namaController.text,
                  'alamat': alamatController.text,
                  'telepon': teleponController.text,
                  'gambar': gambarController.text,
                };

                dataString[index] = jsonEncode(updatedKos);
                await prefs.setStringList('kos_list', dataString);

                Navigator.pop(context);
                _muatDataKos();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildItem(Map<String, dynamic> kos, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: kos['gambar'] != null && kos['gambar'].toString().isNotEmpty
            ? Image.network(
                kos['gambar'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.home, size: 40),
        title: Text(kos['nama'] ?? 'Tanpa Nama'),
        subtitle: Text('${kos['alamat']}\nTelp: ${kos['telepon']}'),
        isThreeLine: true,
        trailing: SizedBox(
          width: 96,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => _editKosDialog(index),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _hapusKos(index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lihat Semua Kos")),
      body: daftarKos.isEmpty
          ? const Center(child: Text("Belum ada data kos."))
          : ListView.builder(
              itemCount: daftarKos.length,
              itemBuilder: (context, index) =>
                  _buildItem(daftarKos[index], index),
            ),
    );
  }
}
