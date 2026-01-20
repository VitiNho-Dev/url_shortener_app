class HomeModel {
  final String url;
  final List<String> urlShorteners;

  const HomeModel({
    required this.url,
    required this.urlShorteners,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      url: json['urlEncurtada'] as String,
      urlShorteners: [],
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
}
