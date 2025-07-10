import 'package:flutter/material.dart';
import '../model/kos.dart';

class TambahKosPage extends StatefulWidget {
  final Function(Kos) onKosDitambahkan;

  const TambahKosPage({Key? key, required this.onKosDitambahkan})
    : super(key: key);

  @override
  State<TambahKosPage> createState() => _TambahKosPageState();
}

class _TambahKosPageState extends State<TambahKosPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _teleponController = TextEditingController();
  final _gambarUrlController = TextEditingController();
  final _kategoriController = TextEditingController();
  final _pemilikController = TextEditingController();
  final _hargaController = TextEditingController(); // ✅ Tambahkan

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _teleponController.dispose();
    _gambarUrlController.dispose();
    _kategoriController.dispose();
    _pemilikController.dispose();
    _hargaController.dispose(); // ✅ Jangan lupa dispose
    super.dispose();
  }

  void _simpanKos() {
    if (_formKey.currentState!.validate()) {
      final kosBaru = Kos(
        _namaController.text,
        _alamatController.text,
        _teleponController.text,
        _gambarUrlController.text,
        kategori: _kategoriController.text,
        pemilik: _pemilikController.text,
        harga: int.tryParse(_hargaController.text) ?? 0, // ✅ Parsing harga
      );

      widget.onKosDitambahkan(kosBaru);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Kos")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: "Nama Kos"),
                validator: _required,
              ),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(labelText: "Alamat"),
                validator: _required,
              ),
              TextFormField(
                controller: _teleponController,
                decoration: const InputDecoration(labelText: "Telepon"),
                validator: _required,
              ),
              TextFormField(
                controller: _gambarUrlController,
                decoration: const InputDecoration(labelText: "URL Gambar"),
              ),
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(labelText: "Kategori"),
              ),
              TextFormField(
                controller: _pemilikController,
                decoration: const InputDecoration(labelText: "Pemilik"),
              ),
              TextFormField(
                controller: _hargaController,
                decoration: const InputDecoration(
                  labelText: "Harga (Rp)",
                ), // ✅ Harga
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Wajib diisi';
                  if (int.tryParse(value) == null) return 'Harus berupa angka';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _simpanKos,
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _required(String? value) {
    if (value == null || value.isEmpty) return 'Wajib diisi';
    return null;
  }
}
