import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Replace 10.0.2.2 with your Chromebook’s LAN IP if testing on a physical phone
  static const String baseUrl = 'http://10.0.2.2:5000';

  static Future<Map<String, dynamic>?> lookupNfc(String nfcId) async {
    final url = Uri.parse('$baseUrl/lookup');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nfc_id': nfcId}),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body)['data'];
    }
    return null;
  }
}

