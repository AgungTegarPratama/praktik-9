import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  // 🔵 API LAMA (JANGAN DIUBAH)
  static Future<String> checkKelompok4() async {
    final url = Uri.parse(
      'https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok4/check'
    );

    try {
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Status code bukan 200");
      }

    } catch (e) {
      throw Exception("Error API: $e");
    }
  }

  // 🟢 TAMBAHAN: API STREAM LOGS
  static Future<Stream<String>> getLogs() async {
    final request = http.Request(
      'GET',
      Uri.parse('https://api.ppb.widiarrohman.my.id/api/ppb2/stream/logs'), // 🔴 GANTI endpoint logs kamu
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      return response.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter());
    } else {
      throw Exception("Gagal ambil logs");
    }
  }
}