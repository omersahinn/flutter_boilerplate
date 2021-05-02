import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("Start HTTP -->");
    print('Request Method: ' + options.method);
    print('Request Url: ' + options.baseUrl + options.path);
    print('Request Header: ' + options.headers.toString());
    print('Request connectTimeout: ' + options.connectTimeout.toString());
    print('Request receiveTimeout: ' + options.receiveTimeout.toString());

    handler.next(options);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) {
    print('Response StatusCode: ' + response.statusCode.toString());
    print('Response Body: ' + response.data.toString());
    print("<-- END HTTP");

    handler.next(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) {
    print("<-- Error -->");
    print(err.error);
    print(err.message);

    handler.next(err);
  }
}
