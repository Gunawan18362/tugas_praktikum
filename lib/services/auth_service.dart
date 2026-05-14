import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';

class AuthService {
  Future<String?> login(
    String username,
    String password,
  ) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}/api/auth/login",
    );

    final response = await http.post(
      url,
      headers: {
        "Content-Type":
            "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['data']['token'];
    }

    return null;
  }
}