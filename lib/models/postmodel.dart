class PostModel {
  String? profileImg;

  String? name;

  String? postImg;

  String? text;

  String? date;

  PostModel({
    required this.profileImg,
    required this.name,
    required this.text,
    required this.postImg,
    required this.date,
  });

  PostModel.fromJson(json) {
    profileImg=json['profileImg'];
    name=json['name'];
    postImg=json['postImg'];
    date=json['date'];
    text=json['text'];
  }

  toMap() {
    return {
      'profileImg': profileImg,
      'postImg': postImg,
      'name': name,
      'text': text,
      'date': date,
    };
  }
}
