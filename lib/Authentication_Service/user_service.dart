import 'package:firebase_database/firebase_database.dart';

class UserService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('users');

  Future<void> saveUserProfile(String uid, Map<String, dynamic> profileData) async {
    try {
      await _dbRef.child(uid).set(profileData);
      print('User profile saved for uid: $uid');
    } catch (e) {
      print('Error saving user profile for uid $uid: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      final snapshot = await _dbRef.child(uid).get();
      if (snapshot.exists) {
        print('User profile fetched for uid: $uid');
        return Map<String, dynamic>.from(snapshot.value as Map);
      } else {
        print('No user profile found for uid: $uid');
        return null;
      }
    } catch (e) {
      print('Error fetching user profile for uid $uid: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final snapshot = await _dbRef.get();
      if (snapshot.exists) {
        final usersMap = Map<String, dynamic>.from(snapshot.value as Map);
        final usersList = usersMap.entries.map((entry) {
          final userMap = Map<String, dynamic>.from(entry.value);
          userMap['uid'] = entry.key;
          return userMap;
        }).toList();
        print('Fetched all users: ${usersList.length}');
        return usersList;
      } else {
        print('No users found');
        return [];
      }
    } catch (e) {
      print('Error fetching all users: $e');
      return [];
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await _dbRef.child(uid).remove();
      print('User deleted: $uid');
    } catch (e) {
      print('Error deleting user $uid: $e');
      throw e;
    }
  }
}
