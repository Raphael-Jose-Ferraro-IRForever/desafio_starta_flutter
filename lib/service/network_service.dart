import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../config/app_interceptor.dart';

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

const String ERROR_MESSAGE =
    'Não foi possível concluir sua chamada! Tente novamente mais tarde.';
const String ERROR_CONNECTION_MESSAGE = 'Verifique sua conexão!';

class NetworkService {
  static Dio? _dio;

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: AppConfig.getInstance()!.apiBaseUrl,
    connectTimeout: 60000,
    receiveTimeout: 60000,
  );

  static final instance = NetworkService._();

  NetworkService._() {
    _init();
    addInterceptor(AppInterceptor());
  }

  addInterceptor(Interceptor interceptor) {
    _dio!.interceptors.add(interceptor);
  }

  _init() {
    if (_dio == null) {
      _dio = Dio(_baseOptions);

      (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  Future<dynamic> request(HttpMethod method, String endpoint,
      {Map<String, String>? headers,
      body,
      required bool ignoreInterceptor}) async {
    dynamic response;

    try {
      if (method == HttpMethod.GET) {
        response = await _get(endpoint,
            headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.POST) {
        response = await _post(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.PUT) {
        response = await _put(
          endpoint,
          body: body,
          headers: headers,
          ignoreInterceptor: ignoreInterceptor,
        );
      } else if (method == HttpMethod.PATCH) {
        response = await _patch(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else if (method == HttpMethod.DELETE) {
        response = await _delete(endpoint,
            body: body, headers: headers, ignoreInterceptor: ignoreInterceptor);
      } else {
        print('HttpMethod unknown!');
      }
    } catch (e) {
      print(
          "Exception Request => ($method) => ${_dio!.options.baseUrl}$endpoint");

      if (e is DioError) {
        var dioError = e;
        print('Exception Dio => ${dioError.response}');

        if (dioError.response!.statusCode == 300) {
          return dioError.response!.data['data'];
        }

        String? message = dioError.response?.data['data'] ??
            dioError.response?.data['message'];
        if (message != null) {
          print('message -> $message');
          throw Exception(message);
        } else {
          throw Exception('Erro desconhecido!');
        }
      } else {
        throw Exception(ERROR_MESSAGE);
      }
    }

    return response;
  }

  Future<dynamic> _get(String endpoint,
      {Map<String, String>? headers, bool ignoreInterceptor = false}) async {
    Response response = await _dio!.get(
      endpoint,
      options: await _getCustomConfig(headers, ignoreInterceptor),
    );

    return _generateResponse(response);
  }

  Future<dynamic> _post(String endpoint,
      {Map? headers, body, bool ignoreInterceptor = false}) async {
    Response response = await _dio!.post(
      endpoint,
      data: body,
      options: await _getCustomConfig(
          headers as Map<String, String>?, ignoreInterceptor),
    );

    return _generateResponse(response);
  }

  Future<dynamic> _put(String endpoint,
      {Map? headers, body, bool ignoreInterceptor = false}) async {
    Response response = await _dio!.put(
      endpoint,
      data: body,
      options: await _getCustomConfig(
          headers as Map<String, String>?, ignoreInterceptor),
    );
    return _generateResponse(response);
  }

  Future<dynamic> _patch(String endpoint,
      {Map? headers, body, bool ignoreInterceptor = false}) async {
    Response response = await _dio!.patch(
      endpoint,
      data: body,
      options: await _getCustomConfig(
          headers as Map<String, String>?, ignoreInterceptor),
    );
    return _generateResponse(response);
  }

  Future<dynamic> _delete(String endpoint,
      {Map? headers, body, bool ignoreInterceptor = false}) async {
    Response response = await _dio!.delete(
      endpoint,
      data: body,
      options: await _getCustomConfig(
          headers as Map<String, String>?, ignoreInterceptor),
    );
    return _generateResponse(response);
  }

  dynamic _generateResponse(Response? response) {
    if (response == null) {
      print('404 - Response null');
      throw Exception(ERROR_MESSAGE);
    }

    final int statusCode = response.statusCode!;

    print('Request Headers => ${response.requestOptions.headers}');
    print(
        "Request (${response.requestOptions.method}) => ${response.requestOptions.uri}");
    print("Response ($statusCode) => ${jsonEncode(response.data)}");

    final decoded = response.data;

    if (statusCode < 200 || statusCode > 204) {
      if (decoded != null && decoded["data"] != null) {
        throw Exception(decoded["data"]);
      }
      throw Exception(ERROR_MESSAGE);
    }

    if (decoded is List) {
      return decoded;
    } else if (decoded is Map) {
      if (decoded["data"] != null) {
        return decoded["data"];
      } else if (decoded.isNotEmpty) {
        return decoded;
      } else {
        return null;
      }
    } else {
      return decoded;
    }
  }

  Future<Options> _getCustomConfig(
      Map<String, String>? customHeader, bool ignoreInterceptor) async {
    Options options = Options();
    options.extra = {'ignoreInterceptor': ignoreInterceptor};
    options.headers = await _getDefaultHeader(customHeader);
    return options;
  }

  Future<Map<String, String>> _getDefaultHeader(
      Map<String, String>? customHeader) async {
    Map<String, String> header = {
      "Content-Type": "application/json;charset=UTF-8"
    };
    if (customHeader != null) {
      header.addAll(customHeader);
    }
    return header;
  }
}
