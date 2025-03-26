class AuthService {
  static final Map<String, Map<String, String>> _users = {};

  void logout() {
    // Logic to clear user session data
    _users.clear(); // Clear all user data for logout
  }



  Future<String?> login(String email, String password) async {

    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    if (_users[email]?['password'] == password) {
        return _users[email]?['role'];
    } else {
        return null;
    }


  }

  Future<bool> register(String email, String password, String role) async { // Allow specifying roles


    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    if (_users.containsKey(email)) { // Check if email is already registered

      return false; // Email already registered
    } else { // Register new user with specified role
      _users[email] = {'password': password, 'role': role}; // Store password and role


      return true;
    }
  }
}
