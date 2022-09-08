import '../service/network_service.dart';

class ApiBase {
  final _network = NetworkService.instance;

  Future<dynamic> request(
    HttpMethod method,
    String endpoint, {
    Map<String, String>? headers,
    body,
    bool cacheFirst = false,
    bool ignoreInterceptor = false,
  }) {
    return _network
        .request(method, endpoint,
            headers: headers, body: body, ignoreInterceptor: ignoreInterceptor)
        .then((response) {
      return response;
    }).catchError((error) {
      throw (error);
    });
  }
}
