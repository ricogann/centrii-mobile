import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:centrii_user/services/base_service.dart';

class ServiceService extends BaseService {
  static final _baseUrl = BaseService().getBaseUrl();

  static Future<String> getFiltered() async {
    try {
      final uri = Uri.parse('${_baseUrl}/v1/service/data/filtered');
      final response = await http.get(
        uri,
      );
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
