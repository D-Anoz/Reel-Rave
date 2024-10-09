// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

ResultModel resultModelFromJson(String str) => ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) => json.encode(data.toJson());

class ResultModel {
  final List<Result> results;

  ResultModel({
    required this.results,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final OriginalLanguage originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: originalLanguageValues.map[json["original_language"]]!,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum OriginalLanguage {
  EN,
  KO
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "ko": OriginalLanguage.KO
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

// MovieResult.dart
class MovieResult {
  final int? id;
  final String? originalTitle;
  final String? title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final int? voteCount;
  final List<int>? genreIds;
  final String? releaseDate;
  final double? popularity;

  MovieResult({
    this.id,
    this.originalTitle,
    this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.voteCount,
    this.genreIds,
    this.releaseDate,
    this.popularity,
  });

  // Factory method to create a MovieResult from JSON with optional fields
  factory MovieResult.fromJson(Map<String, dynamic> json) {
    return MovieResult(
      id: json['id'],
      originalTitle: json['original_title'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] != null) ? json['vote_average'].toDouble() : null,
      voteCount: json['vote_count'],
      genreIds: json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : null,
      releaseDate: json['release_date'],
      popularity: (json['popularity'] != null) ? json['popularity'].toDouble() : null,
    );
  }
}

// MovieResponse.dart
class MovieResponse {
  final int? page;
  final List<MovieResult>? results;

  MovieResponse({
    this.page,
    this.results,
  });

  // Factory method to create a MovieResponse from JSON with optional fields
  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List?;
    List<MovieResult>? movieList = list != null ? list.map((i) => MovieResult.fromJson(i)).toList() : null;

    return MovieResponse(
      page: json['page'],
      results: movieList,
    );
  }
}
