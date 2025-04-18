import 'package:firebase_database/firebase_database.dart';

class ReportService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('reports');

  Future<void> addReport(String uid, Map<String, dynamic> reportData) async {
    final dataWithUserId = Map<String, dynamic>.from(reportData);
    dataWithUserId['userId'] = uid;
    await _dbRef.push().set(dataWithUserId);
  }

  Future<List<Map<String, dynamic>>> getReports() async {
    final snapshot = await _dbRef.get();
    if (snapshot.exists) {
      final reportsMap = Map<String, dynamic>.from(snapshot.value as Map);
      List<Map<String, dynamic>> allReports = [];
      reportsMap.forEach((key, value) {
        final report = Map<String, dynamic>.from(value);
        allReports.add(report);
      });
      return allReports;
    } else {
      return [];
    }
  }
}
