class Movie {
  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final List<Rating> ratings;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbID;
  final String type;
  final String dvd;
  final String boxOffice;
  final String production;
  final String website;
  final String response;

  Movie({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.type,
    required this.dvd,
    required this.boxOffice,
    required this.production,
    required this.website,
    required this.response,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      rated: json['Rated'] ?? '',
      released: json['Released'] ?? '',
      runtime: json['Runtime'] ?? '',
      genre: json['Genre'] ?? '',
      director: json['Director'] ?? '',
      writer: json['Writer'] ?? '',
      actors: json['Actors'] ?? '',
      plot: json['Plot'] ?? '',
      language: json['Language'] ?? '',
      country: json['Country'] ?? '',
      awards: json['Awards'] ?? '',
      poster: json['Poster'] ?? '',
      ratings: (json['Ratings'] as List<dynamic>?)
          ?.map((rating) => Rating.fromJson(rating))
          .toList() ??
          [],
      metascore: json['Metascore'] ?? '',
      imdbRating: json['imdbRating'] ?? '',
      imdbVotes: json['imdbVotes'] ?? '',
      imdbID: json['imdbID'] ?? '',
      type: json['Type'] ?? '',
      dvd: json['DVD'] ?? '',
      boxOffice: json['BoxOffice'] ?? '',
      production: json['Production'] ?? '',
      website: json['Website'] ?? '',
      response: json['Response'] ?? '',
    );
  }
}

class Rating {
  final String source;
  final String value;

  Rating({required this.source, required this.value});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      source: json['Source'] ?? '',
      value: json['Value'] ?? '',
    );
  }
}
