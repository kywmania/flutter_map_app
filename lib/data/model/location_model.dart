class LocationModel {
  final String? title;
  final String? category;
  final String? roadAddress;

  LocationModel({
    required this.title,
    required this.category,
    required this.roadAddress,
  });

  LocationModel.fromJson(Map<String, dynamic> map)
      : this(
          title: map['title'],
          category: map['category'],
          roadAddress: map['roadAddress'],
        );

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "category": category,
      "roadAddress": roadAddress,
    };
  }
}
