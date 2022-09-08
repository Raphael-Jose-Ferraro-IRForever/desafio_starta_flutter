import '../../models/item_movie_recommendation_model.dart';

class MovieDetailsModel {
  String urlImagem;
  String title;
  int votes;
  double views;
  List<ItemMovieRecommendationModel> moviesRecommendations;

  MovieDetailsModel(
      {required this.urlImagem,
      required this.title,
      required this.votes,
      required this.views,
      required this.moviesRecommendations});

  Map<String, dynamic> toMap() {
    return {
      'urlImagem': this.urlImagem,
      'votes': this.votes,
      'likes': this.views,
      'title': this.title,
      'moviesRecommendations': this.moviesRecommendations
    };
  }

  factory MovieDetailsModel.convertInMovie(Map<String, dynamic> map) =>
      MovieDetailsModel(
          urlImagem: 'https://image.tmdb.org/t/p/w500/${map['poster_path']}',
          votes: map['vote_count'],
          views: map['popularity'],
          title: map['title'],
          moviesRecommendations: []);
}
