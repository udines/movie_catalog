class Movie {
  Movie({
    this.adult,
    this.backdropPath,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount
  });

  Movie.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool;
    backdropPath = json['backdrop_path'] as String;
    budget = json['budget'] as int;
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((Map<String, dynamic> v) {
        genres.add(Genres.fromJson(v));
      });
    }
    homepage = json['homepage'] as String;
    id = json['id'] as int;
    imdbId = json['imdb_id'] as String;
    originalLanguage = json['original_language'] as String;
    originalTitle = json['original_title'] as String;
    overview = json['overview'] as String;
    popularity = json['popularity'] as num;
    posterPath = json['poster_path'] as String;
    if (json['production_companies'] != null) {
      productionCompanies = <ProductionCompanies>[];
      json['production_companies'].forEach((Map<String, dynamic> v) {
        productionCompanies.add(ProductionCompanies.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = <ProductionCountries>[];
      json['production_countries'].forEach((Map<String, dynamic> v) {
        productionCountries.add(ProductionCountries.fromJson(v));
      });
    }
    releaseDate = json['release_date'] as String;
    revenue = json['revenue'] as int;
    runtime = json['runtime'] as int;
    if (json['spoken_languages'] != null) {
      spokenLanguages = <SpokenLanguages>[];
      json['spoken_languages'].forEach((Map<String, dynamic> v) {
        spokenLanguages.add(SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'] as String;
    tagline = json['tagline'] as String;
    title = json['title'] as String;
    video = json['video'] as bool;
    voteAverage = json['vote_average'] as num;
    voteCount = json['vote_count'] as int;
  }

  bool adult;
  String backdropPath;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  num popularity;
  String posterPath;
  List<ProductionCompanies> productionCompanies;
  List<ProductionCountries> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguages> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  num voteAverage;
  int voteCount;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['budget'] = budget;
    if (genres != null) {
      data['genres'] = genres.map((Genres v) => v.toJson()).toList();
    }
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    if (productionCompanies != null) {
      data['production_companies'] =
          productionCompanies.map((ProductionCompanies v) => v.toJson()).toList();
    }
    if (productionCountries != null) {
      data['production_countries'] =
          productionCountries.map((ProductionCountries v) => v.toJson()).toList();
    }
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    if (spokenLanguages != null) {
      data['spoken_languages'] =
          spokenLanguages.map((SpokenLanguages v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}

class Genres {
  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
  }

  int id;
  String name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ProductionCompanies {
  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    logoPath = json['logo_path'] as String;
    name = json['name'] as String;
    originCountry = json['origin_country'] as String;
  }

  int id;
  String logoPath;
  String name;
  String originCountry;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }
}

class ProductionCountries {
  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'] as String;
    name = json['name'] as String;
  }

  String iso31661;
  String name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    return data;
  }
}

class SpokenLanguages {
  SpokenLanguages({this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'] as String;
    name = json['name'] as String;
  }

  String iso6391;
  String name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iso_639_1'] = iso6391;
    data['name'] = name;
    return data;
  }
}
