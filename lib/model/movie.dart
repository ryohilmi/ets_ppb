const String tableMovies = 'movies';

class MovieFields {
  static final List<String> values = [
    id, title, description, image, time
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String image = 'image';
  static const String time = 'time';
}

class Movie {
  final int? id;
  final String title;
  final String description;
  final String image;
  final DateTime createdTime;

  const Movie({
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.createdTime
  });

  Movie copy({
    int? id,
    String? title,
    String? description,
    String? image,
    DateTime? createdTime,
  }) => Movie(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    image: image ?? this.image,
    createdTime: createdTime ?? this.createdTime,
  );

  static Movie fromJson(Map<String, Object?> json) => Movie(
    id: json[MovieFields.id] as int?,
    title: json[MovieFields.title] as String,
    description: json[MovieFields.description] as String,
    image: json[MovieFields.image] as String,
    createdTime: DateTime.parse(json[MovieFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    MovieFields.id: id,
    MovieFields.title: title,
    MovieFields.description: description,
    MovieFields.image: image,
    MovieFields.time: createdTime.toIso8601String(),
  };

}