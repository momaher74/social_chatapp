import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/cubit/appstates.dart';
import 'package:socialapp/main.dart';
import 'package:socialapp/models/messagemodel.dart';
import 'package:socialapp/models/postmodel.dart';
import 'package:socialapp/models/usermodel.dart';
import 'package:socialapp/screens/chatscreen.dart';
import 'package:socialapp/screens/feedscreen.dart';
import 'package:socialapp/screens/settingscreen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void register({
    required email,
    required password,
    required phone,
    required name,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userModel = UserModel(
        verified: false,
        email: email,
        password: password,
        phone: phone,
        name: name,
        coverImg:
            'https://img.freepik.com/free-photo/emotional-bearded-male-has-surprised-facial-expression-astonished-look-dressed-white-shirt-with-red-braces-points-with-index-finger-upper-right-corner_273609-16001.jpg?w=996',
        profileImg:
            'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=996',
        uId: value.user!.uid,
        bio: 'write your bio ...',
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .set(userModel!.toMap())
          .then((value) {})
          .catchError((error) {});
      uId = value.user!.uid;
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState());
    });
  }

  String? uId;

  login({
    required email,
    required password,
  }) {
    emit(LoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uId = value.user!.uid;
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginErrorState());
    });
  }

  //     .get().then((value) {
  // value.docs.forEach((element) {
  // userModel = UserModel.fromJson(element.data());
  // });
  getUser() {
    // print(uId.toString() + '55555555555555555555555555555555555555555555555555555555') ;
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(token)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState());
    });
  }

  int currentIndex = 0;

  changeVerify(bool? verify) {
    verify = true;
    emit(ChangeVerifySuccessState());
  }

  changeNavBar(int index) {
    currentIndex = index;
    emit(ChangeNavBarSuccessState());
  }

  List screen = const [
    FeedScreen(),
    ChatScreen(),
    SettingScreen(),
  ];

  List title = [
    'Feeds',
    'Chats',
    'Settings',
  ];

  ImagePicker picker = ImagePicker();
  File? postImage;
  File? profileImage;
  File? coverImage;
  File? chatImage;

  Future<void> pickChatImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(PickChatImgSuccessState());
    } else {
      print('No  Profile image selected.');
      print('No  Profile image selected.');
      emit(PickChatImgErrorState());
    }
  }

  Future<void> pickPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PickPostImgSuccessState());
    } else {
      print('No  Profile image selected.');
      emit(PickPostImgErrorState());
    }
  }

  Future<void> pickProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickProfileImgSuccessState());
    } else {
      print('No  Profile image selected.');
      emit(PickProfileImgErrorState());
    }
  }

  Future<void> pickCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(PickCoverImgSuccessState());
    } else {
      print('No  Cover image selected.');
      emit(PickCoverImgErrorState());
    }
  }

  post({
    required String? text,
    required String? date,
  }) {
    emit(UploadPostLoadingState());
    if (postImage != null) {
      FirebaseStorage.instance
          .ref()
          .child('postImg')
          .putFile(postImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          PostModel? postModel = PostModel(
            profileImg: userModel!.profileImg,
            name: userModel!.name,
            text: text,
            postImg: value.toString(),
            date: date,
          );
          FirebaseFirestore.instance
              .collection('posts')
              .add(postModel.toMap())
              .then((value) {
            emit(UploadPostSuccessState());
          }).catchError((error) {
            emit(UploadPostErrorState());
          });
        }).catchError((error) {
          emit(UploadPostErrorState());
        });
      }).catchError((error) {
        emit(UploadPostErrorState());
      });
    } else {
      PostModel? postModel = PostModel(
          profileImg: userModel!.profileImg,
          name: userModel!.name,
          text: text,
          postImg: null,
          date: date);
      FirebaseFirestore.instance
          .collection('posts')
          .add(postModel.toMap())
          .then((value) {
        emit(UploadPostSuccessState());
      }).catchError((error) {
        emit(UploadPostErrorState());
      });
    }
  }

  cancelPostImg() {
    postImage = null;
    emit(CancelPostImgSuccessState());
  }

  cancelChatImg() {
    chatImage = null;
    emit(CancelChatImgSuccessState());
  }

  List allPosts = [];
  List postId = [];
  List likes = [];

  getPosts() {
    allPosts = [];
    emit(GetAllPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date')
        .get()
        .then((value) {
      for (var element in value.docs) {
        allPosts.add(element);
        postId.add(element.id);
      }
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
        }).catchError((error) {});
      });
      emit(GetAllPostsSuccessState());
    }).catchError((error) {
      emit(GetAllPostsErrorState());
    });
  }

  likePost({required postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .add({'like': true}).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState());
    });
  }

  bool edit = false;

  changeEdit() {
    edit = !edit;
    emit(ChangeEditSuccessState());
  }

  editInfo({
    required name,
    required email,
    required bio,
    required password,
    required phone,
  }) {
    emit(EditInfoLoadingState());
    userModel = UserModel(
      email: email,
      password: password,
      phone: phone,
      name: name,
      coverImg: userModel!.coverImg,
      profileImg: userModel!.profileImg,
      uId: userModel!.uId,
      bio: bio,
      verified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc('$token')
        .update(userModel!.toMap())
        .then((value) {
      getUser();
      emit(EditInfoSuccessState());
    }).catchError((error) {
      emit(EditInfoErrorState());
    });
  }

  editProfileImg() {
    emit(EditProfileImgLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('profile img')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userModel = UserModel(
          email: userModel!.email,
          password: userModel!.password,
          phone: userModel!.phone,
          name: userModel!.name,
          coverImg: userModel!.coverImg,
          profileImg: value,
          uId: userModel!.uId,
          bio: userModel!.bio,
          verified: userModel!.verified,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc('$token')
            .update(userModel!.toMap())
            .then((value) {
          getUser();
          emit(EditProfileImgSuccessState());
        }).catchError((error) {
          emit(EditProfileImgErrorState());
        });
      }).catchError((error) {
        emit(EditProfileImgErrorState());
      });
    }).catchError((error) {
      emit(EditProfileImgErrorState());
    });
  }

  editCoverImg() {
    emit(EditCoverImgLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('profile img')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        userModel = UserModel(
          email: userModel!.email,
          password: userModel!.password,
          phone: userModel!.phone,
          name: userModel!.name,
          coverImg: value,
          profileImg: userModel!.profileImg,
          uId: userModel!.uId,
          bio: userModel!.bio,
          verified: userModel!.verified,
        );
        FirebaseFirestore.instance
            .collection('users')
            .doc('$token')
            .update(userModel!.toMap())
            .then((value) {
          getUser();
          emit(EditCoverImgSuccessState());
        }).catchError((error) {
          emit(EditCoverImgErrorState());
        });
      }).catchError((error) {
        emit(EditCoverImgErrorState());
      });
    }).catchError((error) {
      emit(EditCoverImgErrorState());
    });
  }

  List allUsers = [];
  List usersId = [];

  getAllUsers() {
    emit(GetAllUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != token) {
          allUsers.add(UserModel.fromJson(element.data()));
          usersId.add(element.id);
          print(element.id);
        }
      });

      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersErrorState());
    });
  }

  void sendMessage({
    required String? senderId,
    required String? receiverId,
    required String? date,
    required String? text,
  }) {
    MessageModel? messageModel = MessageModel(
      senderId: senderId,
      receiverId: receiverId,
      date: date,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    recMessage(receiverId: receiverId);
  }

  List messages = [];

  void recMessage({
    required String? receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });

      emit(RecMessageSuccessState());
    });
  }
}

// FirebaseFirestore.instance
//     .collection('users')
// .doc(userModel!.uId)
// .collection('chat')
// .doc(receiverId)
// .collection('messages')
// .snapshots()
//     .listen((event) {
// messages = [];
// event.docs.forEach((element) {
// messages.add(element.data());
// });
// print(messages.length.toString() + '    hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh') ;
// emit(RecMessageSuccessState());
// });
