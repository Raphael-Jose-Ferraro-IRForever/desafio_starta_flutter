import 'package:desafio_starta_flutter/models/movie_recommendation_model.dart';
import '../models/movie_model.dart';
import '../service/network_service.dart';
import 'base_api.dart';

class MovieApi extends ApiBase {
  Future<dynamic> obtainMovie({required int idMovie}) {
    final uri = Uri(path: 'movie/$idMovie');
    return request(HttpMethod.GET, uri.toString()).then((response) {
      if (response == null) return response;
      return MovieModel.fromMap(response);
    }).catchError((error) {
      throw error;
    });
  }

  Future<dynamic> obtainMovieRecommendation({required int idMovie}) {
    final uri = Uri(path: 'movie/$idMovie/similar');
    return request(HttpMethod.GET, uri.toString()).then((response) {
      if (response == null) return response;
      return MovieRecommendationModel.fromMap(response);
    }).catchError((error) {
      throw error;
    });
  }

  Future<dynamic> obtainGenres() {
    final uri = Uri(path: '/genre/movie/list');
    return request(HttpMethod.GET, uri.toString()).then((response) {
      return response;
    }).catchError((error) {
      throw error;
    });
  }
}
