class GenreModel {
  GenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreModel.fromMap(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
