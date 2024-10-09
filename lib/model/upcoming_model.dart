class UpcomingModel {
  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;

  UpcomingModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory UpcomingModel.fromJson(Map<String, dynamic> json) => UpcomingModel(
        page: json["page"],
        results: json["results"] != null ? List<Result>.from(json["results"].map((x) => Result.fromJson(x))) : [],
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": results != null ? List<dynamic>.from(results!.map((x) => x.toJson())) : [],
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  final bool adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool video;
  final double? voteAverage;
  final int? voteCount;

  Result({
    required this.adult,
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
    required this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] != null ? List<int>.from(json["genre_ids"].map((x) => x)) : [],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": genreIds != null ? List<dynamic>.from(genreIds!.map((x) => x)) : [],
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
