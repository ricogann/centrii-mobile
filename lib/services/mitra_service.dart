import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:centrii_user/services/base_service.dart';

class MitraService extends BaseService {
  static final _baseUrl = BaseService().getBaseUrl();

  static Future<String> get() async {
    try {
      final uri = Uri.parse('${_baseUrl}/v1/mitra/');
      final response = await http.get(
        uri,
      );
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } catch (e) {
      print("Exception during login: $e");
      return "Login service error";
    }
  }
}
