// To parse this JSON data, do
//
//     final movieVideosModel = movieVideosModelFromJson(jsonString);

class MovieVideosModel {
  MovieVideosModel({
    required this.id,
    required this.results,
  });

  final int id;
  final List<Result> results;

  factory MovieVideosModel.fromJson(Map<String, dynamic> json) =>
      MovieVideosModel(
        id: json["id"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  Result({
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });

  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final DateTime publishedAt;
  final String id;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );
}
