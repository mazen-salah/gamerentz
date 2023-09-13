import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamerentz/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> setUser(String uid) async {
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);
    final userDocSnapshot = await userDocRef.get();

    if (userDocSnapshot.exists) {
      _user = User.fromFirestore(userDocSnapshot);
      notifyListeners();
    }
  }

  Future<void> addGameToFavorites(String gameId) async {
    if (_user != null) {
      await _user!.addGameToFavorites(gameId);
      notifyListeners();
    }
  }

  Future<void> removeGameFromFavorites(String gameId) async {
    if (_user != null) {
      await _user!.removeGameFromFavorites(gameId);
      notifyListeners();
    }
  }
}
