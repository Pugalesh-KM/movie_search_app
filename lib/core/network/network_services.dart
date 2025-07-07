import 'package:dio/dio.dart';
import 'dio_client.dart';

class NetworkServices {
  final Dio _dio;
  final String baseUrl;

  NetworkServices({required this.baseUrl}) : _dio = DioClient.createDio();

  Future<Response> get(String endpoint, {Map<String, dynamic>? params, Map<String, dynamic>? headers}) async {
    return await _dio.get('$baseUrl$endpoint', queryParameters: params, options: Options(headers: headers));
  }

  Future<Response> post(String endpoint, Map<String, dynamic> data, {Map<String, dynamic>? headers}) async {
    return await _dio.post('$baseUrl$endpoint', data: data, options: Options(headers: headers));
  }

  Future<Response> put(String endpoint, Map<String, dynamic> data, {Map<String, dynamic>? headers}) async {
    return await _dio.put('$baseUrl$endpoint', data: data, options: Options(headers: headers));
  }

  Future<Response> patch(String endpoint, Map<String, dynamic> data, {Map<String, dynamic>? headers}) async {
    return await _dio.patch('$baseUrl$endpoint', data: data, options: Options(headers: headers));
  }

  Future<Response> delete(String endpoint, {Map<String, dynamic>? headers}) async {
    return await _dio.delete('$baseUrl$endpoint', options: Options(headers: headers));
  }
}