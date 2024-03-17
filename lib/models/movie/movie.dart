import 'package:finding_your_movies_demo/resource/extensions/double_ex.dart';
import 'package:finding_your_movies_demo/resource/extensions/duration_ex.dart';
import 'package:finding_your_movies_demo/resource/extensions/int_ex.dart';
import 'package:json_annotation/json_annotation.dart';
part 'movie.g.dart';

@JsonSerializable(createToJson: false)
class Movie {
  final String id;

  final String title;

  @JsonKey(fromJson: IntEX.parseFromDynamic)
  final int year;

  final List<String> genres;

  final List<int> ratings;

  final String poster;

  final String contentRating;

  @JsonKey(fromJson: DurationEX.parseFromISO8601)
  final Duration duration;

  final String releaseDate;

  final int averageRating;

  final String originalTitle;

  final String storyline;

  final List<String> actors;

  @JsonKey(fromJson: DoubleEX.parseFromDynamic)
  final double imdbRating;

  final String posterurl;

  Movie(
      {required this.id,
      required this.year,
      required this.duration,
      this.releaseDate = '',
      this.title = '',
      this.genres = const <String>[],
      this.ratings = const <int>[],
      this.poster = '',
      this.contentRating = '',
      this.averageRating = 0,
      this.originalTitle = '',
      this.storyline = '',
      this.actors = const <String>[],
      this.imdbRating = 0.0,
      this.posterurl = ''});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
