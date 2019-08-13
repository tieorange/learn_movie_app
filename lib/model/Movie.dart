// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:kt_dart/collection.dart';
import 'package:kt_dart/src/collection/kt_list.dart';

final String posterPathBaseUrl = "https://image.tmdb.org/t/p/w500/";

MovieResponseModel welcomeFromJson(String str) =>
    MovieResponseModel.fromJson(json.decode(str));

String welcomeToJson(MovieResponseModel data) => json.encode(data.toJson());

class MovieResponseModel {
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results;

  MovieResponseModel({
    this.page,
    this.totalResults,
    this.totalPages,
    this.results,
  });

  KtList<Movie> map() => new KtList.from(this.results);

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      new MovieResponseModel(
        page: json["page"],
        totalResults: json["total_results"],
        totalPages: json["total_pages"],
        results:
            new List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "total_results": totalResults,
        "total_pages": totalPages,
        "results": new List<dynamic>.from(results.map((x) => x.toJson())),
      };

}

class Movie {
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;

  String get posterUrl {
    return posterPathBaseUrl + posterPath;
  }

  OriginalLanguage originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  DateTime releaseDate;

  Movie({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => new Movie(
        voteCount: json["vote_count"],
        id: json["id"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        title: json["title"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"],
        genreIds: new List<int>.from(json["genre_ids"].map((x) => x)),
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        adult: json["adult"],
        overview: json["overview"],
        releaseDate: DateTime.parse(json["release_date"]),
      );

  Map<String, dynamic> toJson() => {
        "vote_count": voteCount,
        "id": id,
        "video": video,
        "vote_average": voteAverage,
        "title": title,
        "popularity": popularity,
        "poster_path": posterPath,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "genre_ids": new List<dynamic>.from(genreIds.map((x) => x)),
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "adult": adult,
        "overview": overview,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
      };
}

enum OriginalLanguage { EN, JA }

final originalLanguageValues =
    new EnumValues({"en": OriginalLanguage.EN, "ja": OriginalLanguage.JA});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
