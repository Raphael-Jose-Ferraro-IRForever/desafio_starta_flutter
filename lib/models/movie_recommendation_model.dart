// To parse this JSON data, do
//
//     final movieRecommendationModel = movieRecommendationModelFromMap(jsonString);
import 'dart:convert';

class MovieRecommendationModel {
  MovieRecommendationModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  MovieRecommendationModel copyWith({
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      MovieRecommendationModel(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory MovieRecommendationModel.fromJson(String str) =>
      MovieRecommendationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieRecommendationModel.fromMap(Map<String, dynamic> json) =>
      MovieRecommendationModel(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
    required this.posterPath,
    required this.popularity,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final dynamic backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final DateTime releaseDate;
  final dynamic posterPath;
  final double popularity;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "poster_path": posterPath,
        "popularity": popularity,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
