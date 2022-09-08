import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    if (options.extra['ignoreInterceptor'] == false) {
      var token = '166137cda4b6fd5649d2835307fd9ece';
      options.queryParameters.addAll({'api_key' : '$token'});
    }
    return super.onRequest(options, handler);
  }
}