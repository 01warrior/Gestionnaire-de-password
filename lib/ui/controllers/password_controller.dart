import 'package:flutter/material.dart';
import '../../data/models/password_model.dart';
import '../../data/database/database_helper.dart';
import '../views/ screens/home_screen.dart';

class PasswordController extends ChangeNotifier {
  List<Password> _passwords = [];
  bool _isLoading = true;
  DatabaseHelper _databaseHelper = DatabaseHelper();


  List<Password> get passwords => _passwords;
  bool get isLoading => _isLoading;


  PasswordController() {
    loadPasswords();
  }

  Future<void> loadPasswords() async {
    _isLoading = true;
    notifyListeners();
    _passwords = await _databaseHelper.getAllPasswords();
    _isLoading = false;
    notifyListeners();

  }

  Future<void> addPassword(Password password) async {
    await _databaseHelper.insertPassword(password);
    await loadPasswords(); // Reload passwords after adding
  }

  Future<void> updatePassword(Password password) async {
    await _databaseHelper.updatePassword(password);
    await loadPasswords();
  }

  Future<void> deletePassword(int id) async {
    await _databaseHelper.deletePassword(id);
    await loadPasswords();
  }
  Future<Password?> getPasswordById(int id) async {
    return await _databaseHelper.getPasswordById(id);
  }
  void sortPasswords(SortOption option) {
    switch (option) {
      case SortOption.websiteName:
        _passwords.sort((a, b) => a.websiteName.compareTo(b.websiteName));
        break;
      case SortOption.latestSave:
        _passwords.sort((a,b) => b.id!.compareTo(a.id!));
        break;
    }
    notifyListeners();
  }

}