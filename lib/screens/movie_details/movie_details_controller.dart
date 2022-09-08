import 'dart:math';
import 'dart:ui';
import 'package:desafio_starta_flutter/api/movie_api.dart';
import 'package:mobx/mobx.dart';
import '../../models/genre_model.dart';
import '../../models/item_movie_recommendation_model.dart';
import '../../models/movie_recommendation_model.dart';
import '../../utils/message_util.dart';
import 'movie_details_model.dart';

part 'movie_details_controller.g.dart';

class MovieDetailsController = MovieDetailsControllerBase
    with _$MovieDetailsController;

const String RESPONSE_NULL =
    'Ops! Parece que tivemos um problema, por favor tente novamente.';

abstract class MovieDetailsControllerBase with Store {
  MovieApi movieApi = MovieApi();

  List<GenreModel> listGenres = [];

  @observable
  bool isLoading = false;

  @observable
  MovieDetailsModel? movieDetails;

  @action
  obtainGenres(VoidCallback callback) {
    isLoading = true;
    movieApi.obtainGenres().then((listMovieGenres) {
      if (listMovieGenres != null) {
        listGenres = List<GenreModel>.from(listMovieGenres['genres']
            .map((genres) => GenreModel.fromMap(genres)));
        callback();
      } else {
        MessageUtil.showAlertOk(RESPONSE_NULL);
      }
    }).catchError((error) {
      isLoading = false;
      MessageUtil.showAlertOk(error.toString());
    });
  }

  @action
  obtainMovie({required int idMovie}) {
    isLoading = true;
    movieApi.obtainMovie(idMovie: idMovie).then((movie) {
      if (movie != null) {
        movieDetails = MovieDetailsModel.convertInMovie(movie.toMap());
        _obtainMovieRecommendation(idMovie: idMovie);
      } else {
        MessageUtil.showAlertOk(RESPONSE_NULL,
            onOkPressed: () => obtainMovie(idMovie: Random().nextInt(10000)));
      }
    }).catchError((error) {
      isLoading = false;
      MessageUtil.showAlertOk(error.toString(),
          onOkPressed: () => obtainMovie(idMovie: Random().nextInt(10000)));
    });
  }

  _obtainMovieRecommendation({required int idMovie}) {
    movieApi.obtainMovieRecommendation(idMovie: idMovie).then((movie) {
      isLoading = false;
      if (movie != null) {
        MovieRecommendationModel copy = movie;
        movieDetails!.moviesRecommendations =
            List<ItemMovieRecommendationModel>.from(copy.results.map((x) =>
                ItemMovieRecommendationModel.convertToMovie(
                    x.toMap(), listGenres)));
      } else {
        MessageUtil.showAlertOk(RESPONSE_NULL,
            onOkPressed: () => obtainMovie(idMovie: Random().nextInt(10000)));
      }
    }).catchError((error) {
      isLoading = false;
      MessageUtil.showAlertOk(error.toString(),
          onOkPressed: () => obtainMovie(idMovie: Random().nextInt(10000)));
    });
  }
}
