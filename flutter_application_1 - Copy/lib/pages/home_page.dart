import 'package:flutter/material.dart';
import '../model/kos.dart' as model;
import '../services/kos_service.dart';
import 'lihat_semua_kos_page.dart';
import 'tambah_kos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<model.Kos> _semuaKos = [];

  @override
  void initState() {
    super.initState();

    _semuaKos.addAll([
      model.Kos(
        'Kos Mawar',
        'Jl. Melati No.1',
        '081234567890',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgVF-kJ_JDB1HNeoUiKJRpvkzokIg5GfMtSQ&s',
        kategori: 'Putri',
        pemilik: 'Bu Sari',
        harga: 750000,
      ),
      model.Kos(
        'Kos Melati',
        'Jl. Kenanga No.2',
        '081234567891',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSn7xeAWU1TNouLNV5NhN92qp-UcFbdmVvRg&s',
        kategori: 'Putra',
        pemilik: 'Pak Andi',
        harga: 650000,
      ),
      model.Kos(
        'Kos Sakura',
        'Jl. Sakura No.3',
        '081234567892',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGA9yDbqPCeGdHmm71IXPft0l0nQAhK6Rzgg&s',
        kategori: 'Campur',
        pemilik: 'Mas Budi',
        harga: 800000,
      ),
    ]);

    // 🔄 Tambahan dari KosService jika ada
    KosService.bacaKos().then((data) {
      if (mounted) {
        setState(() {
          _semuaKos.addAll(data);
        });
      }
    });
  }

  void _tambahKosBaru(model.Kos kos) {
    setState(() {
      _semuaKos.add(kos);
    });
    KosService.simpanKos(_semuaKos);
  }

  void _filterByKategori(String kategori) {
    final filtered = _semuaKos
        .where((kos) => kos.kategori.toLowerCase() == kategori.toLowerCase())
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LihatSemuaKosPage(daftarKos: filtered),
      ),
    );
  }

  void _filterByPemilik(String pemilik) {
    final filtered = _semuaKos
        .where(
          (kos) => kos.pemilik.toLowerCase().contains(pemilik.toLowerCase()),
        )
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LihatSemuaKosPage(daftarKos: filtered),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KOSinAJA')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Kategori Kos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryCard("Putra"),
                _buildCategoryCard("Putri"),
                _buildCategoryCard("Campur"),
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
              children: [
                _buildUserAvatar("Pak Andi"),
                _buildUserAvatar("Bu Sari"),
                _buildUserAvatar("Mas Budi"),
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

  Widget _buildCategoryCard(String title) {
    return GestureDetector(
      onTap: () => _filterByKategori(title),
      child: Column(
        children: [
          const CircleAvatar(child: Icon(Icons.home)),
          const SizedBox(height: 4),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(String name) {
    return GestureDetector(
      onTap: () => _filterByPemilik(name),
      child: Column(
        children: [
          const CircleAvatar(child: Icon(Icons.person)),
          const SizedBox(height: 4),
          Text(name),
        ],
      ),
    );
  }
}
