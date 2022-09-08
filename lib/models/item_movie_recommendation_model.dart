import 'genre_model.dart';

class ItemMovieRecommendationModel {
  final int year;
  final int id;
  final String urlImage;
  final String title;
  final List<GenreModel> genres;

  ItemMovieRecommendationModel(
      {required this.year,
      required this.title,
      required this.urlImage,
      required this.genres,
      required this.id});

  Map<String, dynamic> toMap() {
    return {
      'year': this.year,
      'year': this.id,
      'urlImage': this.urlImage,
      'title': this.title,
      'genres': this.genres,
    };
  }

  factory ItemMovieRecommendationModel.convertToMovie(
      Map<String, dynamic> map, List<GenreModel> listGenres) {
    return ItemMovieRecommendationModel(
      year: DateTime.parse(map['release_date']).year,
      urlImage: 'https://image.tmdb.org/t/p/w500/${map['poster_path']}',
      title: map['title'],
      id: map['id'],
      genres: List<GenreModel>.from(map["genre_ids"]
          .map((x) => listGenres.firstWhere((element) => element.id == x))),
    );
  }
}
