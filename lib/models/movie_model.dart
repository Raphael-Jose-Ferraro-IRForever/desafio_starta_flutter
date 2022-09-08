// To parse this JSON data, do
//
//     final movieModel = movieModelFromMap(jsonString);
import 'dart:convert';

import 'genre_model.dart';

class MovieModel {
  MovieModel({
    required this.adult,
    required this.id,
    required this.imdbId,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.genres,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final int id;
  final String imdbId;
  final String originalTitle;
  final String overview;
  final double popularity;
  final List<GenreModel> genres;
  final dynamic posterPath;
  final DateTime releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieModel copyWith({
    bool? adult,
    int? id,
    String? imdbId,
    String? originalTitle,
    String? overview,
    double? popularity,
    dynamic posterPath,
    DateTime? releaseDate,
    List<GenreModel>? genres,
    int? revenue,
    int? runtime,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) =>
      MovieModel(
        adult: adult ?? this.adult,
        id: id ?? this.id,
        imdbId: imdbId ?? this.imdbId,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        genres: genres ?? this.genres,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        revenue: revenue ?? this.revenue,
        runtime: runtime ?? this.runtime,
        status: status ?? this.status,
        tagline: tagline ?? this.tagline,
        title: title ?? this.title,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory MovieModel.fromJson(String str) => MovieModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
    adult: json["adult"],
    id: json["id"],
    imdbId: json["imdb_id"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromMap(x))),
        releaseDate: DateTime.parse(json["release_date"]),
    revenue: json["revenue"],
    runtime: json["runtime"],
    status: json["status"],
    tagline: json["tagline"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toMap() => {
    "adult": adult,
    "id": id,
    "imdb_id": imdbId,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "genres": List<dynamic>.from(genres.map((x) => x.toMap())),
    "poster_path": posterPath,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "revenue": revenue,
    "runtime": runtime,
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
