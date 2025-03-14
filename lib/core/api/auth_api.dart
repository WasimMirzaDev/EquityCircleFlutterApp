import 'api_service.dart'; // your centralized API service

class AuthApi {
  // Function to handle user login
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await ApiService.postRequest('/login', {
        'email': email,
        'password': password,
      });
      return response
          .data; // assuming it returns a JSON map containing user data and token
    } catch (error) {
      // Handle errors appropriately
      throw Exception("Login failed: $error");
    }
  }

  static Future<Map<String, dynamic>> register(
    String name,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    try {
      final response = await ApiService.postRequest('/register', {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });
      return response
          .data; // assuming it returns a JSON map containing user data and token
    } catch (error) {
      // Handle errors appropriately
      throw Exception("Login failed: $error");
    }
  }

  static Future<Map<String, dynamic>> getUserData(String token) async {
    try {
      final response = await ApiService.getRequest('/user', token);
      return response.data;
    } catch (error) {
      // Handle errors appropriately
      throw Exception("Login failed: $error");
    }
  }
}
