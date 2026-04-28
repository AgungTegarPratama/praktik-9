import 'dart:convert';
import 'package:http/http.dart' as http;
import 'get_started_model.dart';

class GetStartedService {
  Future<GetStartedModel> fetchData() async {
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8000/api/2026/uts/A/kelompok4/get-started"),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return GetStartedModel.fromJson(jsonData['data']);
    } else {
      throw Exception("Gagal ambil data");
    }
  }
}
