import 'dart:convert';

import 'package:android_dev_test/model/user_result.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _baseUrl = 'https://reqres.in/api/users';

  Future<UserResult> getUser() async {
    final response = await http
        .get(Uri.parse(_baseUrl + '?' + 'page=1' + '&' + 'per_page=10'));
    if (response.statusCode == 200) {
      return UserResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user result');
    }
  }
}
