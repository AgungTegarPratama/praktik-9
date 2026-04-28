import 'package:http/http.dart' as http;

class ApiService {

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
        return response.body; // 🔥 LANGSUNG RETURN STRING
      } else {
        throw Exception("Status code bukan 200");
      }

    } catch (e) {
      throw Exception("Error API: $e");
    }
  }
}