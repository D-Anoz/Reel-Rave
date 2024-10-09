class ForYouModel {
  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;

  ForYouModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory ForYouModel.fromJson(Map<String, dynamic> json) => ForYouModel(
        page: json["page"] ?? 0,
        results: json["results"] != null ? List<Result>.from(json["results"].map((x) => Result.fromJson(x))) : [],
        totalPages: json["total_pages"] ?? 0,
        totalResults: json["total_results"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results != null ? List<dynamic>.from(results!.map((x) => x.toJson())) : [],
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final OriginalLanguage? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  Result({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: json["genre_ids"] != null ? List<int>.from(json["genre_ids"].map((x) => x)) : [],
        id: json["id"] ?? 0,
        originalLanguage: originalLanguageValues.map[json["original_language"]]!,
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"] ?? '',
        popularity: json["popularity"]?.toDouble() ?? 0.0,
        posterPath: json["poster_path"] ?? '',
        releaseDate: json["release_date"] != null ? DateTime.parse(json["release_date"]) : DateTime.now(),
        title: json["title"] ?? '',
        video: json["video"] ?? false,
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": genreIds != null ? List<dynamic>.from(genreIds!.map((x) => x)) : [],
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate != null ? "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}" : null,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum OriginalLanguage {
  EN,
  HI,
  ZH
}

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "hi": OriginalLanguage.HI,
  "zh": OriginalLanguage.ZH,
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
