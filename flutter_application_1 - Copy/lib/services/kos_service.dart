import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/kos.dart';

class KosService {
  static Future<List<Kos>> bacaKos() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('kos_list') ?? [];
    return data.map((e) => Kos.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> simpanKos(List<Kos> kosList) async {
    final prefs = await SharedPreferences.getInstance();
    final data = kosList.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('kos_list', data);
  }
}
