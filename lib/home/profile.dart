import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  final UserService _userService = UserService();
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    if (_currentUser != null) {
      try {
        final profileData = await _userService.getUserProfile(_currentUser!.uid);
        if (profileData != null) {
          nameController.text = profileData['name'] ?? '';
          phoneController.text = profileData['phone'] ?? '';
          vehicleController.text = profileData['vehicle'] ?? '';
          contactController.text = profileData['contact'] ?? '';
        }
      } catch (e) {
        print('Error loading user profile: $e');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveProfile() async {
    if (_currentUser != null) {
      try {
        await _userService.saveUserProfile(_currentUser!.uid, {
          'name': nameController.text,
          'phone': phoneController.text,
          'vehicle': vehicleController.text,
          'contact': contactController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile saved successfully')));
      } catch (e) {
        print('Error saving profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to save profile')));
      }
    }
  }

  Future<void> _removeProfile() async {
    if (_currentUser != null) {
      try {
        await _userService.saveUserProfile(_currentUser!.uid, {
          'name': '',
          'phone': '',
          'vehicle': '',
          'contact': '',
        });
        nameController.clear();
        phoneController.clear();
        vehicleController.clear();
        contactController.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile removed successfully')));
      } catch (e) {
        print('Error removing profile: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to remove profile')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Profile Management')),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Management'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: vehicleController,
                decoration: InputDecoration(labelText: 'Vehicle Information'),
              ),
              TextField(
                controller: contactController,
                decoration: InputDecoration(labelText: 'Contact Details'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save'),
              ),
              ElevatedButton(
                onPressed: _removeProfile,
                child: Text('Remove'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
