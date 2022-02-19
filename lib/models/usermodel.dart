class UserModel {
  String? name;

  String? password;

  String? coverImg;

  String? profileImg;

  String? uId;

  String? phone;

  String? email;

  String? bio;
  bool? verified;

  UserModel({
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
    required this.coverImg,
    required this.profileImg,
    required this.uId,
    required this.bio,
    required this.verified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
    uId = json['uId'];
    profileImg = json['profileImg'];
    coverImg = json['coverImg'];
    bio = json['bio'];
    verified = json['verified'];
  }

  toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'uId': uId,
      'profileImg': profileImg,
      'coverImg': coverImg,
      'bio': bio,
      'verified': verified,
    };
  }
}
