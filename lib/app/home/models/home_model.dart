class HomeModel {
  final int id;
  final String urlLong;
  final String urlShort;

  const HomeModel({
    required this.id,
    required this.urlLong,
    required this.urlShort,
  });

  factory HomeModel.fromJson(Map<String, Object?> json) {
    return HomeModel(
      id: json['id'] as int,
      urlLong: json['urlLong'] as String,
      urlShort: json['urlShort'] as String,
    );
  }

  static Map<String, dynamic> toJson(HomeModel model) {
    return {
      'id': model.id,
      'urlLong': model.urlLong,
      'urlShort': model.urlShort,
    };
  }

  HomeModel copyWith({
    int? id,
    String? urlLong,
    String? urlShort,
  }) {
    return HomeModel(
      id: id ?? this.id,
      urlLong: urlLong ?? this.urlLong,
      urlShort: urlShort ?? this.urlShort,
    );
  }
}
