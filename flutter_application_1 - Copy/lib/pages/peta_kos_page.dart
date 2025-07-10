import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PetaKosPage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String namaKos;

  const PetaKosPage({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.namaKos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lokasi $namaKos')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('lokasiKos'),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: namaKos),
          )
        },
      ),
    );
  }
}
