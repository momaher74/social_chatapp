class CommentModel {
  String? profileImg;

  String? name;

  String? text;

  String? date;

  CommentModel({
    required this.profileImg,
    required this.name,
    required this.text,
    required this.date,
  });

  CommentModel.fromJson(json) {
    profileImg=json['profileImg'];
    name=json['name'];
    date=json['date'];
    text=json['text'];
  }

  toMap() {
    return {
      'profileImg': profileImg,
      'name': name,
      'text': text,
      'date': date,
    };
  }
}
