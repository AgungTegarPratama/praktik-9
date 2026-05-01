import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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

// 🟡 LOGIN (USERNAME + PASSWORD)
  static Future<bool> login(String username, String password) async {
    final url = Uri.parse(
      'https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok4/login'
    );

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json", // ✅ JSON
        },
        body: jsonEncode({
          "username": username,
          "password": password,
        }),
      );

      print("STATUS LOGIN: ${response.statusCode}");
      print("BODY LOGIN: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // 🔥 SIMPAN TOKEN
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["token"]);

        print("TOKEN: ${data["token"]}");

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("ERROR LOGIN: $e");
      return false;
    }
  }

  // 🔐 AMBIL TOKEN
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
  // 🚪 LOGOUT
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  // 👤 GET PROFILE
  static Future<Map<String, dynamic>?> getProfile() async {
    final url = Uri.parse(
      'https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok4/user/profile'
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print("STATUS PROFILE: ${response.statusCode}");
      print("BODY PROFILE: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["data"];
      } else {
        return null;
      }
    } catch (e) {
      print("ERROR PROFILE: $e");
      return null;
    }
  }
}