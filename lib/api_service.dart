import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "http://10.0.2.2/flutter_api/get_data.php"; // Use 10.0.2.2 for localhost on Android Emulator

  Future<List<dynamic>> fetchData() async {
    var result = await http.get(Uri.parse(apiUrl));
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
