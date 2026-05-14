import 'package:flutter/material.dart';

import '../core/storage/secure_storage.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service =
      AuthService();

  bool isLoading = false;

  Future<bool> login(
    String username,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();

    final token = await _service.login(
      username,
      password,
    );

    isLoading = false;
    notifyListeners();

    if (token != null) {
      await SecureStorage.saveToken(token);
      return true;
    }

    return false;
  }
}