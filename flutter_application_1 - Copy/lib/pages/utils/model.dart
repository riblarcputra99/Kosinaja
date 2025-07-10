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

  factory Kos.fromJson(Map<String, dynamic> json) => Kos(
    json['nama'],
    json['alamat'],
    json['telepon'],
    json['gambar'],
  );
}
