class User {
  final String name;
  final int age;
  final List<String> images;
  final List<String> favourites;
  final String location;
  final String audio;
  bool isBrokenHeart;

  User({
    required this.audio,
    this.isBrokenHeart = false,
    required this.favourites,
    required this.name,
    required this.age,
    required this.images,
    required this.location,
  });
}
