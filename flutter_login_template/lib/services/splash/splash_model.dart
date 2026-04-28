class SplashModel {
  final String imageUrl;
  final String title;
  final String description;

  SplashModel({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  factory SplashModel.fromJson(Map<String, dynamic> json) {
    return SplashModel(
      imageUrl: json['image_url'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
    );
  }
}