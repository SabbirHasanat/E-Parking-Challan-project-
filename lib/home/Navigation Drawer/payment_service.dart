import 'package:firebase_database/firebase_database.dart';

class PaymentService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('users');

  Future<void> addPayment(String uid, Map<String, dynamic> paymentData) async {
    await _dbRef.child(uid).child('payments').push().set(paymentData);
  }

  Future<List<Map<String, dynamic>>> getPayments(String uid) async {
    final snapshot = await _dbRef.child(uid).child('payments').get();
    if (snapshot.exists) {
      final paymentsMap = Map<String, dynamic>.from(snapshot.value as Map);
      // Include the payment ID in each payment map
      return paymentsMap.entries.map((entry) {
        final payment = Map<String, dynamic>.from(entry.value);
        payment['id'] = entry.key;
        return payment;
      }).toList();
    } else {
      return [];
    }
  }

  Future<void> updatePayment(String uid, String paymentId, Map<String, dynamic> paymentData) async {
    await _dbRef.child(uid).child('payments').child(paymentId).update(paymentData);
  }

  Future<void> deletePayment(String uid, String paymentId) async {
    await _dbRef.child(uid).child('payments').child(paymentId).remove();
  }
}
