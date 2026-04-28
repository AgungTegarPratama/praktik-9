import 'dart:convert';
import 'package:http/http.dart' as http;
import 'splash_model.dart';

class SplashService {
  static Future<List<SplashModel>> fetchSplashData() async {
    final response = await http.get(
      Uri.parse("https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok4/splash-screen"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List list = data['data'];

      return list.map((e) => SplashModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal load splash data");
    }
  }
}