import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  final String _baseUrl = "http://192.168.18.101:5000";
  //final String _baseUrl = "http://192.168.100.11:5000";

  // ==========================
  // User Routes
  // =========================
  Future<http.Response> login(Map<String, dynamic> credentials) async {
    String url = '$_baseUrl/user/login';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(credentials),
      headers: {"Content-Type": "application/json"},
    );
    return response;
  }

  Future<http.Response> getUsers() async {
    String url = '$_baseUrl/users';
    var response = await http.get(Uri.parse(url));
    return response;
  }

  Future<http.Response> getUser(int userId) async {
    String url = '$_baseUrl/user/$userId';
    var response = await http.get(Uri.parse(url));
    return response;
  }

  Future<http.Response> createUser(Map<String, dynamic> userData) async {
    String url = '$_baseUrl/user';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(userData),
      headers: {"Content-Type": "application/json"},
    );
    return response;
  }

  Future<http.Response> updateUser(
      int userId, Map<String, dynamic> userData) async {
    String url = '$_baseUrl/user/$userId';
    var response = await http.put(
      Uri.parse(url),
      body: jsonEncode(userData),
      headers: {"Content-Type": "application/json"},
    );
    return response;
  }

  Future<http.Response> deleteUser(int userId) async {
    String url = '$_baseUrl/user/$userId';
    var response = await http.delete(Uri.parse(url));
    return response;
  }
}
