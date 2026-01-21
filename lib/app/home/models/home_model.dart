class HomeModel {
  final String urlLong;
  final String urlShort;

  const HomeModel({
    required this.urlLong,
    required this.urlShort,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      urlLong: '',
      urlShort: json['urlEncurtada'] as String,
      // urlShorteners: (json['urlsEncurtadas'] as List<Object?>)
      //     .cast<Map<String, dynamic>>()
      //     .map((url) => url['url'] as String)
      //     .toList(),
    );
  }

  static Map<String, dynamic> toJson(String url) {
    return {
      'url': url,
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
