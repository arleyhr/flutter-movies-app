import 'package:movies_app/src/config.dart';

class MovieEntity {
	String originalLanguage;
	String imdbId;
	bool video;
	String title;
	String backdropPath;
	int revenue;
	List<MovieGenre> genres;
	double popularity;
	List<MovieProductionCountry> productionCountries;
	int id;
	int voteCount;
	int budget;
	String overview;
	String originalTitle;
	int runtime;
	String posterPath;
	List<MovieSpokenLanguage> spokenLanguages;
	List<MovieProductionCompany> productionCompanies;
	String releaseDate;
	String voteAverage;
	dynamic belongsToCollection;
	String tagline;
	bool adult;
	String homepage;
	String status;

	MovieEntity({this.originalLanguage, this.imdbId, this.video, this.title, this.backdropPath, this.revenue, this.genres, this.popularity, this.productionCountries, this.id, this.voteCount, this.budget, this.overview, this.originalTitle, this.runtime, this.posterPath, this.spokenLanguages, this.productionCompanies, this.releaseDate, this.voteAverage, this.belongsToCollection, this.tagline, this.adult, this.homepage, this.status});

	MovieEntity.fromJson(Map<String, dynamic> json) {
		originalLanguage = json['original_language'];
		imdbId = json['imdb_id'];
		video = json['video'];
		title = json['title'];
		backdropPath = json['backdrop_path'];
		revenue = json['revenue'];
		if (json['genres'] != null) {
			genres = new List<MovieGenre>();(json['genres'] as List).forEach((v) { genres.add(new MovieGenre.fromJson(v)); });
		}
		popularity = json['popularity'];
		if (json['production_countries'] != null) {
			productionCountries = new List<MovieProductionCountry>();(json['production_countries'] as List).forEach((v) { productionCountries.add(new MovieProductionCountry.fromJson(v)); });
		}
		id = json['id'];
		voteCount = json['vote_count'];
		budget = json['budget'];
		overview = json['overview'];
		originalTitle = json['original_title'];
		runtime = json['runtime'];
		posterPath = json['poster_path'];
		if (json['spoken_languages'] != null) {
			spokenLanguages = new List<MovieSpokenLanguage>();(json['spoken_languages'] as List).forEach((v) { spokenLanguages.add(new MovieSpokenLanguage.fromJson(v)); });
		}
		if (json['production_companies'] != null) {
			productionCompanies = new List<MovieProductionCompany>();(json['production_companies'] as List).forEach((v) { productionCompanies.add(new MovieProductionCompany.fromJson(v)); });
		}
		releaseDate = json['release_date'];
		voteAverage = json['vote_average'].toString();
		belongsToCollection = json['belongs_to_collection'];
		tagline = json['tagline'];
		adult = json['adult'];
		homepage = json['homepage'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['original_language'] = this.originalLanguage;
		data['imdb_id'] = this.imdbId;
		data['video'] = this.video;
		data['title'] = this.title;
		data['backdrop_path'] = this.backdropPath;
		data['revenue'] = this.revenue;
		if (this.genres != null) {
      data['genres'] =  this.genres.map((v) => v.toJson()).toList();
    }
		data['popularity'] = this.popularity;
		if (this.productionCountries != null) {
      data['production_countries'] =  this.productionCountries.map((v) => v.toJson()).toList();
    }
		data['id'] = this.id;
		data['vote_count'] = this.voteCount;
		data['budget'] = this.budget;
		data['overview'] = this.overview;
		data['original_title'] = this.originalTitle;
		data['runtime'] = this.runtime;
		data['poster_path'] = this.posterPath;
		if (this.spokenLanguages != null) {
      data['spoken_languages'] =  this.spokenLanguages.map((v) => v.toJson()).toList();
    }
		if (this.productionCompanies != null) {
      data['production_companies'] =  this.productionCompanies.map((v) => v.toJson()).toList();
    }
		data['release_date'] = this.releaseDate;
		data['vote_average'] = this.voteAverage;
		data['belongs_to_collection'] = this.belongsToCollection;
		data['tagline'] = this.tagline;
		data['adult'] = this.adult;
		data['homepage'] = this.homepage;
		data['status'] = this.status;
		return data;
	}

	String getPosterImage({ int width }) {
		return getMdbImage(src: posterPath, width: width);
	}

}

class MovieGenre {
	String name;
	int id;

	MovieGenre({this.name, this.id});

	MovieGenre.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}

class MovieProductionCountry {
	String iso31661;
	String name;

	MovieProductionCountry({this.iso31661, this.name});

	MovieProductionCountry.fromJson(Map<String, dynamic> json) {
		iso31661 = json['iso_3166_1'];
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['iso_3166_1'] = this.iso31661;
		data['name'] = this.name;
		return data;
	}
}

class MovieSpokenLanguage {
	String name;
	String iso6391;

	MovieSpokenLanguage({this.name, this.iso6391});

	MovieSpokenLanguage.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		iso6391 = json['iso_639_1'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['iso_639_1'] = this.iso6391;
		return data;
	}
}

class MovieProductionCompany {
	String logoPath;
	String name;
	int id;
	String originCountry;

	MovieProductionCompany({this.logoPath, this.name, this.id, this.originCountry});

	MovieProductionCompany.fromJson(Map<String, dynamic> json) {
		logoPath = json['logo_path'];
		name = json['name'];
		id = json['id'];
		originCountry = json['origin_country'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['logo_path'] = this.logoPath;
		data['name'] = this.name;
		data['id'] = this.id;
		data['origin_country'] = this.originCountry;
		return data;
	}
}
