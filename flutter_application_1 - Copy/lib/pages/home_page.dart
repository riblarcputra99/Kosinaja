import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/category_card.dart';
import '../widgets/user_avatar.dart';


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

  factory Kos.fromJson(Map<String, dynamic> json) =>
      Kos(json['nama'], json['alamat'], json['telepon'], json['gambar']);
}

Future<void> simpanKos(List<Kos> data) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonData = jsonEncode(data.map((e) => e.toJson()).toList());
  await prefs.setString('kos_list', jsonData);
}

Future<List<Kos>> bacaKos() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonData = prefs.getString('kos_list');
  if (jsonData == null) return [];
  final List<dynamic> list = jsonDecode(jsonData);
  return list.map((e) => Kos.fromJson(e)).toList();
}

class LihatSemuaKosPage extends StatelessWidget {
  final List<Kos> daftarKos;
  const LihatSemuaKosPage({super.key, required this.daftarKos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lihat Semua Kos")),
      body: daftarKos.isEmpty
          ? const Center(child: Text("Belum ada data kos."))
          : ListView.builder(
              itemCount: daftarKos.length,
              itemBuilder: (context, index) {
                final kos = daftarKos[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: kos.gambar.isNotEmpty
                        ? Image.network(
                            kos.gambar,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.home, size: 40),
                    title: Text(kos.nama),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(kos.alamat),
                        Text("Telp: ${kos.telepon}"),
                      ],
                    ),
                  ),
                );
              },
            ),
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

  void _simpanKos() {
    final nama = _namaController.text.trim();
    final alamat = _alamatController.text.trim();
    final telepon = _teleponController.text.trim();
    final gambar = _gambarController.text.trim();

    if (nama.isEmpty || alamat.isEmpty || telepon.isEmpty) return;

    widget.onKosDitambahkan(Kos(nama, alamat, telepon, gambar));
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
              const SizedBox(height: 16),
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Kos> _semuaKos = [];

  @override
  void initState() {
    super.initState();
    bacaKos().then((data) {
      setState(() {
        _semuaKos.addAll(data);
      });
    });
  }

  void _tambahKosBaru(Kos kos) {
    setState(() {
      _semuaKos.add(kos);
    });
    simpanKos(_semuaKos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KOSinAJA'),
        actions: const [Icon(Icons.refresh), SizedBox(width: 12)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pakai kode KOS20",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text("Dapatkan diskon 20% saat booking kos pertamamu!"),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Kategori Kos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CategoryCard(icon: Icons.male, title: "Putra"),
                CategoryCard(icon: Icons.female, title: "Putri"),
                CategoryCard(icon: Icons.people, title: "Campur"),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Akses Cepat",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                UserAvatar(name: "Pak Andi"),
                UserAvatar(name: "Bu Sari"),
                UserAvatar(name: "Mas Budi"),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LihatSemuaKosPage(daftarKos: _semuaKos),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Lihat Semua Kos"),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TambahKosPage(onKosDitambahkan: _tambahKosBaru),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Tambah Kos"),
            ),
          ],
        ),
      ),
    );
  }
}
