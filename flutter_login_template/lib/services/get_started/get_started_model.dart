class GetStartedModel {
  String imageUrl;
  String title;
  String description;

  GetStartedModel({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  factory GetStartedModel.fromJson(Map<String, dynamic> json) {
    return GetStartedModel(
      imageUrl: json['image_url'],
      title: json['title'],
      description: json['description'],
    );
  }
}