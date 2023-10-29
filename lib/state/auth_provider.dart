import 'package:flutter/material.dart';
import 'package:toguishi/state/storage_service.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuthenticated = false;

  Future<void> checkAuthentication() async {
    try {
      final token = await StorageService().read('token');
      isAuthenticated = token != null;
      notifyListeners();
    } catch (e) {
      isAuthenticated = false;
      notifyListeners();
    }
  }
}
