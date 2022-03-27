class AnimalItem {
  final int id;
  final String name;
  final String image;

  AnimalItem({
    required this.id,
    required this.name,
    required this.image,
  });

  factory AnimalItem.fromJson(Map<String, dynamic> json) {
    return AnimalItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  AnimalItem.fromJson2(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],

        image = json['image'];
}