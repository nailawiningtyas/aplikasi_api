import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _apiKey = 'SRQdIgPshlwRARwBVQXF2l2pdo1p7mx0onv3aa5N';
  static const String _baseUrl = 'https://api.nal.usda.gov/fdc/v1/foods/search';

  static Future<List<dynamic>?> searchFoods(String query) async {
    final response =
        await http.get(Uri.parse('$_baseUrl?api_key=$_apiKey&query=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['foods'];
    } else {
      return null;
    }
  }
}
