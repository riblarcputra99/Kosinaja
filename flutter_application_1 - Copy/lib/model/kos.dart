class Kos {
  final String nama;
  final String alamat;
  final String telepon;
  final String gambarUrl;
  final String kategori;
  final String pemilik;
  final int harga;

  Kos(
    this.nama,
    this.alamat,
    this.telepon,
    this.gambarUrl, {
    this.kategori = '',
    this.pemilik = '',
    this.harga = 0,
  });

  // ✅ Untuk membaca dari JSON
  factory Kos.fromJson(Map<String, dynamic> json) {
    return Kos(
      json['nama'],
      json['alamat'],
      json['telepon'],
      json['gambarUrl'],
      kategori: json['kategori'] ?? '',
      pemilik: json['pemilik'] ?? '',
      harga: json['harga'] ?? 0,
    );
  }

  // ✅ Untuk menyimpan ke JSON
  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'alamat': alamat,
      'telepon': telepon,
      'gambarUrl': gambarUrl,
      'kategori': kategori,
      'pemilik': pemilik,
      'harga': harga,
    };
  }
}
