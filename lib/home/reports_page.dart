import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'report_service.dart';
import 'user_service.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final ReportService _reportService = ReportService();
  final UserService _userService = UserService();
  User? _currentUser;
  bool _isAdmin = false;
  bool _isLoading = true;
  List<Map<String, dynamic>> _reports = [];
  Map<String, String> _userNamesCache = {};

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _checkAdminAndLoadReports();
  }

  Future<void> _checkAdminAndLoadReports() async {
    try {
      if (_currentUser != null) {
        final profile = await _userService.getUserProfile(_currentUser!.uid);
        if (profile != null && profile['role'] == 'admin') {
          setState(() {
            _isAdmin = true;
          });
          await _loadAllReports();
        } else {
          setState(() {
            _isAdmin = false;
          });
          await _loadUserReports();
        }
      } else {
        setState(() {
          _isAdmin = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error in _checkAdminAndLoadReports: $e');
      setState(() {
        _isAdmin = false;
        _isLoading = false;
      });
    }
  }

  Future<void> _loadAllReports() async {
    try {
      final reports = await _reportService.getReports();
      await _cacheUserNames(reports);
      setState(() {
        _reports = reports;
        _isLoading = false;
      });
    } catch (e) {
      print('Error in _loadAllReports: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadUserReports() async {
    try {
      if (_currentUser == null) {
        setState(() {
          _reports = [];
          _isLoading = false;
        });
        return;
      }
      final allReports = await _reportService.getReports();
      final userReports = allReports.where((r) => r['userId'] == _currentUser!.uid).toList();
      await _cacheUserNames(userReports);
      setState(() {
        _reports = userReports;
        _isLoading = false;
      });
    } catch (e) {
      print('Error in _loadUserReports: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _cacheUserNames(List<Map<String, dynamic>> reports) async {
    try {
      Set<String> userIds = reports.map((r) => r['userId'] as String).toSet();
      for (String userId in userIds) {
        final profile = await _userService.getUserProfile(userId);
        if (profile != null && profile['name'] != null) {
          _userNamesCache[userId] = profile['name'];
        } else {
          _userNamesCache[userId] = 'Unknown User';
        }
      }
    } catch (e) {
      print('Error in _cacheUserNames: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Reports')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: _reports.isEmpty
          ? Center(child: Text('No reports found.'))
          : ListView.builder(
              itemCount: _reports.length,
              itemBuilder: (context, index) {
                final report = _reports[index];
                final userId = report['userId'] as String;
                final userName = _userNamesCache[userId] ?? 'Loading...';
                return ListTile(
                  title: Text(_isAdmin ? 'Report from: $userName' : 'Your Report'),
                  subtitle: Text(report['content'] ?? ''),
                  trailing: Text(report['timestamp'] != null
                      ? DateTime.parse(report['timestamp']).toLocal().toString()
                      : ''),
                );
              },
            ),
    );
  }
}
