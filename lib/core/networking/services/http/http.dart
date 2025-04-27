import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  final String baseUrl;

  HttpHelper({required this.baseUrl});

  // GET Request
  Future<http.Response> get({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint')
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: headers);
    return _handleResponse(response);
  }

  // POST Request
  Future<http.Response> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  // Private method to handle response
  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception(
        'Request failed with status: ${response.statusCode}, body: ${response.body}',
      );
    }
  }
}
