import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  late User _currentUser; // Firebase User object
  late String _displayName;
  late String _userImageURL;
  bool _isEditing = false;
  final TextEditingController _displayNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data from Firebase
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _currentUser = user;
        _displayName = user.displayName ?? "User";
        _userImageURL = user.photoURL ?? "";
        _displayNameController.text = _displayName;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      await _currentUser.updateDisplayName(_displayName);
      await _currentUser.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;
      if (updatedUser != null) {
        setState(() {
          _currentUser = updatedUser;
          _displayName = updatedUser.displayName ?? "User";
          _userImageURL = updatedUser.photoURL ?? "";
          _displayNameController.text = _displayName;
          _isEditing = false;
        });
      }
    } catch (error) {
      if (kDebugMode) {
        print("Failed to update display name: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue,
                backgroundImage:
                    _userImageURL.isEmpty ? null : NetworkImage(_userImageURL),
                child: _userImageURL.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _isEditing
                        ? TextFormField(
                            controller: _displayNameController,
                            onChanged: (value) {
                              setState(() {
                                _displayName = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: "Full Name",
                            ),
                          )
                        : Text(
                            _displayName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                    const SizedBox(height: 10),
                    _isEditing
                        ? ElevatedButton(
                            onPressed: () {
                              _updateUserProfile();
                            },
                            child: const Text("Save"),
                          )
                        : TextButton(
                            onPressed: () {
                              setState(() {
                                _isEditing = true;
                              });
                            },
                            child: const Text("Edit Profile"),
                          ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text("Sign Out"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
