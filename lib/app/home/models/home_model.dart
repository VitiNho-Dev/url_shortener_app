class HomeModel {
  final int? id;
  final String longUrl;
  final String shortUrl;

  const HomeModel({
    this.id,
    required this.longUrl,
    required this.shortUrl,
  });

  factory HomeModel.fromJson(Map<String, Object?> json) {
    return HomeModel(
      id: json['id'] as int,
      longUrl: json['long_url'] as String,
      shortUrl: json['short_url'] as String,
    );
  }

  static Map<String, dynamic> toJson(HomeModel model) {
    return {
      'long_url': model.longUrl,
      'short_url': model.shortUrl,
    };
  }
}
