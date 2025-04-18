import 'package:firebase_database/firebase_database.dart';

class AdminService {
  final DatabaseReference _adminRef = FirebaseDatabase.instance.ref().child('admins');

  Future<bool> isAdmin(String uid) async {
    try {
      final snapshot = await _adminRef.child(uid).get();
      print('AdminService.isAdmin: Checking admin for uid $uid, exists: \${snapshot.exists}');
      return snapshot.exists;
    } catch (e) {
      print('AdminService.isAdmin: Error checking admin status for uid $uid: \$e');
      return false;
    }
  }

  Future<void> addAdmin(String uid, Map<String, dynamic> adminData) async {
    await _adminRef.child(uid).set(adminData);
  }

  Future<void> removeAdmin(String uid) async {
    await _adminRef.child(uid).remove();
  }
}
