import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String displayName;
  final String email;
  final List<String> favorites;

  User({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.favorites,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      favorites: (data['favorites'] as List<dynamic>?)
              ?.map((dynamic item) => item as String)
              .toList() ??
          [],
    );
  }

  Future<bool> isGameInFavorites(String gameId) async {
    return favorites.contains(gameId);
  }

  Future<void> addGameToFavorites(String gameId) async {
    if (!favorites.contains(gameId)) {
      favorites.add(gameId);
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(uid);
      await userDocRef.update({
        'favorites': FieldValue.arrayUnion([gameId]),
      });
    }
  }

  Future<void> removeGameFromFavorites(String gameId) async {
    if (favorites.contains(gameId)) {
      favorites.remove(gameId);
      // Update the Firestore document to reflect the changes
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(uid);
      await userDocRef.update({
        'favorites': FieldValue.arrayRemove([gameId]),
      });
    }
  }
}
