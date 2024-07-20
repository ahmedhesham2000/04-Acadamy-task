import 'dart:convert';

import 'package:http/http.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:test/controller/endpoints.dart';

class ApiService {
  static final HttpWithMiddleware _httpClient =
      HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);
  static final HttpClientWithMiddleware _streamedHttpClient =
      HttpClientWithMiddleware.build(middlewares: [
    HttpLogger(
      logLevel: LogLevel.BODY,
    ),
  ]);

  Future<StreamedResponse> send(BaseRequest request) async {
    final response = await _streamedHttpClient.send(request);
    return response;
  }

  Future<Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await _httpClient.patch(url, headers: headers);
    return response;
  }

  Future<Response> get(String url, {Map<String, String>? headers}) async {
    final response = await _httpClient.get(
        Uri.parse(
          baseUrl + url,
        ),
        headers: headers);
    return response;
  }

  Future<Response> put(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await _httpClient.put(
        Uri.parse(
          baseUrl + url,
        ),
        headers: headers);
    return response;
  }

  Future<Response> post(String url,
      {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    if (body is Map) {
      body = Map.from(body)..removeWhere((key, value) => value == null);
    }
    final response = await _httpClient.post(
      Uri.parse(
        baseUrl + url,
      ),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?headers,
      },
      body: body != null ? json.encode(body) : null,
    );
    return response;
  }

  Future<Response> delete(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    final response = await _httpClient.delete(
        Uri.parse(
          baseUrl + url,
        ),
        headers: headers,
        body: body);
    return response;
  }
}
