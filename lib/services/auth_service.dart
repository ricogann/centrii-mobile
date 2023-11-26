import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:centrii_user/services/base_service.dart';

class AuthService extends BaseService {
  static final _baseUrl = BaseService().getBaseUrl();

  static Future<String> login(String email, String password) async {
    try {
      final uri = Uri.parse('${_baseUrl}/v1/auth/login/user');
      final body = {
        "email": email,
        "password": password,
      };
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-type': 'application/json'},
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

  static Future<bool> register(
      String name, String email, String password) async {
    try {
      final uri = Uri.parse('${_baseUrl}/v1/auth/register/user');
      final body = {
        "name": name,
        "email": email,
        "password": password,
      };
      final response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception during register: $e");
      return false;
    }
  }
}
