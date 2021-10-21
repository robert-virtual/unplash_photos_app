class Photo {
  final String id;
  final int likes;
  final String? description;
  final String url;
  final String author;
  final String userImg;

  Photo(
      {required this.id,
      required this.author,
      this.description,
      required this.likes,
      required this.url,
      required this.userImg});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        id: json['id'],
        author: json['user']['name'],
        description: json['alt_description'],
        likes: json['likes'],
        url: json['urls']['regular'],
        userImg: json['user']['profile_image']['medium']);
  }
}
