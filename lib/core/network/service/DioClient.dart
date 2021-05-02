import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/network/service/LoggingInterceptor.dart';
import 'package:flutter_boilerplate/core/network/service/NetworkExceptions.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DioClient {
  final String baseUrl;

  Dio _dio;

  final List<Interceptor> interceptors;

  DioClient(
    this.baseUrl,
    Dio dio, {
    this.interceptors,
  }) {
    _dio = dio ?? Dio();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<dynamic> getHTTP(String url) async {
    try {
      Response response = await _dio.get(url);
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      return handleError(e.response, e);
    }
  }

  Future<dynamic> postHTTP(String url, dynamic data) async {
    try {
      Response response = await _dio.post(url, data: data);
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      return handleError(e.response, e);
    }
  }

  Future<dynamic> putHTTP(String url, dynamic data) async {
    try {
      Response response = await _dio.put(url, data: data);
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      return handleError(e.response, e);
    }
  }

  Future<dynamic> deleteHTTP(String url) async {
    try {
      Response response = await _dio.delete(url);
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      return handleError(e.response, e);
    }
  }

  dynamic handleError(Response response, dynamic err) {
    if (err.error is SocketException) {
      throw NoConnectionError("No Connection");
    }
    if (response == null) {
      throw NotFound();
    }
    switch (response.statusCode) {
      case 400:
        return response.data ?? null;
        break;
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
        break;
      case 404:
        throw NotFound();
        break;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
