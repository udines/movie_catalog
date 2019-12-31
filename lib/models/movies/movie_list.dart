class MovieList {
  MovieList({this.page, this.results, this.totalResults, this.totalPages});

  MovieList.fromJson(Map<String, dynamic> json) {
    page = json['page'] as int;
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((dynamic v) {
        results.add(Results.fromJson(v as Map<String, dynamic>));
      });
    }
    totalResults = json['total_results'] as int;
    totalPages = json['total_pages'] as int;
  }

  int page;
  List<Results> results;
  int totalResults;
  int totalPages;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results.map((Results v) => v.toJson()).toList();
    }
    data['total_results'] = totalResults;
    data['total_pages'] = totalPages;
    return data;
  }
}

class Results {
  Results(
      {this.posterPath,
      this.adult,
      this.overview,
      this.releaseDate,
      this.genreIds,
      this.id,
      this.originalTitle,
      this.originalLanguage,
      this.title,
      this.backdropPath,
      this.popularity,
      this.voteCount,
      this.video,
      this.voteAverage});

  Results.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'] as String;
    adult = json['adult'] as bool;
    overview = json['overview'] as String;
    releaseDate = json['release_date'] as String;
    genreIds = json['genre_ids'].cast<int>() as List<int>;
    id = json['id'] as int;
    originalTitle = json['original_title'] as String;
    originalLanguage = json['original_language'] as String;
    title = json['title'] as String;
    backdropPath = json['backdrop_path'] as String;
    popularity = json['popularity'] as double;
    voteCount = json['vote_count'] as int;
    video = json['video'] as bool;
    voteAverage = json['vote_average'] as double;
  }

  String posterPath;
  bool adult;
  String overview;
  String releaseDate;
  List<int> genreIds;
  int id;
  String originalTitle;
  String originalLanguage;
  String title;
  String backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poster_path'] = posterPath;
    data['adult'] = adult;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_title'] = originalTitle;
    data['original_language'] = originalLanguage;
    data['title'] = title;
    data['backdrop_path'] = backdropPath;
    data['popularity'] = popularity;
    data['vote_count'] = voteCount;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    return data;
  }
}
