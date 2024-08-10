import 'package:flutter/material.dart';
import 'firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Sign in method
  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    _user = await _authService.signInWithEmailAndPassword(email, password);

    _isLoading = false;
    notifyListeners();
  }

  // Register method
  Future<void> register(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    _user = await _authService.registerWithEmailAndPassword(email, password);

    _isLoading = false;
    notifyListeners();
  }

  // Sign out method
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }

  // Auto-login if already authenticated
  void loadCurrentUser() {
    _user = _authService.getCurrentUser();
    notifyListeners();
  }
}
