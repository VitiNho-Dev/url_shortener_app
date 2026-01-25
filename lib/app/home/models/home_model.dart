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
      id: json['id'] as int?,
      longUrl: json['long_url'] as String,
      shortUrl: json['short_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'long_url': longUrl,
      'short_url': shortUrl,
    };
  }
}
