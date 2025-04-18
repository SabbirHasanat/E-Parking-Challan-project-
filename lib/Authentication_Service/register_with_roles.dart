import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'user_service.dart';

class RegisterWithRolesPage extends StatefulWidget {
  @override
  _RegisterWithRolesPageState createState() => _RegisterWithRolesPageState();
}

class _RegisterWithRolesPageState extends State<RegisterWithRolesPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedRole = 'User'; // Default role selection

  void _register() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    var user = await _authService.register(
      emailController.text,
      passwordController.text,
    );

    if (user != null) {
      // Save user role in Realtime Database
      await _userService.saveUserProfile(user.uid, {
        'email': emailController.text,
        'role': _selectedRole,
      });

      setState(() {
        _isLoading = false;
      });

      Navigator.pop(context);
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Registration failed. Please check your email and password.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            DropdownButton<String>(
              value: _selectedRole,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue!;
                });
              },
              items: <String>['User', 'Admin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: Text('Register'),
                  ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Already have an account? Login'),
            ),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
