class HomeModel {
  final String urlLong;
  final String urlShort;

  const HomeModel({
    required this.urlLong,
    required this.urlShort,
  });

  factory HomeModel.fromJson(Map<String, Object?> json) {
    return HomeModel(
      urlLong: json['urlLong'] as String,
      urlShort: json['urlShort'] as String,
    );
  }

  static Map<String, dynamic> toJson(HomeModel model) {
    return {
      'urlLong': model.urlLong,
      'urlShort': model.urlShort,
    };
  }

  HomeModel copyWith({
    String? urlLong,
    String? urlShort,
  }) {
    return HomeModel(
      urlLong: urlLong ?? this.urlLong,
      urlShort: urlShort ?? this.urlShort,
    );
  }
}
