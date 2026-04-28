import 'dart:convert';
import 'package:http/http.dart' as http;
import 'splash_model.dart';

class SplashService {
  Future<List<SplashModel>> fetchSplash() async {
    final response = await http.get(
      Uri.parse("https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok4/splash-screen"),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      List data = jsonData['data'];

      return data.map((e) => SplashModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal ambil data");
    }
  }
}