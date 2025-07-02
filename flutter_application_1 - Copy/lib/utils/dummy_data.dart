import '../models/kos_model.dart';

final List<KosModel> dummyKosList = [
  KosModel(
    id: 'k1',
    nama: 'Kos Putri Mawar',
    lokasi: 'Jl. Merpati No. 12',
    gambarUrl: 'https://picsum.photos/300/200?random=1',
    hargaPerBulan: 500000,
    deskripsi: 'Dekat kampus, kamar mandi dalam, Wi-Fi cepat.',
    tersedia: true,
  ),
  KosModel(
    id: 'k2',
    nama: 'Kos Harapan Indah',
    lokasi: 'Jl. Kenari No. 5',
    gambarUrl: 'https://picsum.photos/300/200?random=2',
    hargaPerBulan: 750000,
    deskripsi: 'Full furnished, AC, dapur bersama.',
    tersedia: false,
  ),
];
