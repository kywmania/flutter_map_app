class LocationModel {
  final String? title;
  final String? category;
  final String? roadAddress;
  final String? link;

  LocationModel({
    required this.title,
    required this.category,
    required this.roadAddress,
    required this.link,
  });

  LocationModel.fromJson(Map<String, dynamic> map)
      : this(
          title: map['title'],
          category: map['category'],
          roadAddress: map['roadAddress'],
          link: map['link'],
        );

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "category": category,
      "roadAddress": roadAddress,
      "link": link
    };
  }
}
