import 'package:http/http.dart' as http;

class ApiService {

 static Future<String> checkKelompok4() async {

   final url = Uri.parse(
     'https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok4/check'
   );

   final response = await http.get(url);

   print(response.statusCode);
   print(response.body);

   if(response.statusCode == 200){
      return response.body;
   }else{
      throw Exception('API gagal');
   }
 }

}