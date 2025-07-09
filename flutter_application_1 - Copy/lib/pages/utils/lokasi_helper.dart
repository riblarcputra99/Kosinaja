import 'package:geocoding/geocoding.dart';

Future<LatLng?> getKoordinatDariAlamat(String alamat) async {
  try {
    List<Location> locations = await locationFromAddress(alamat);
    if (locations.isNotEmpty) {
      return LatLng(locations[0].latitude, locations[0].longitude);
    }
  } catch (e) {
    print('Gagal mengubah alamat: $e');
  }
  return null;
}
