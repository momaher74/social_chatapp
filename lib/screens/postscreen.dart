import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:socialapp/cubit/appcubit.dart';
import 'package:socialapp/cubit/appstates.dart';
import 'package:socialapp/helpers/methods.dart';

import 'homescreen.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var postController = TextEditingController();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is UploadPostSuccessState) {
          cubit.cancelPostImg();
          pushReplacement(context, const HomeScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Post'),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  MyHeightSizedBox(x: 30),
                  TextFormField(
                    controller: postController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'What\'s in your mind ',
                      labelStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                  MyHeightSizedBox(x: 15),
                  if (state is! UploadPostLoadingState)
                    MyElevetedButton(
                      height: 50,
                      width: double.maxFinite,
                      color: Colors.deepPurple,
                      widget: const Text('Post'),
                      function: () {
                        cubit.post(
                          text: postController.text,
                          date: formattedDate.toString(),
                        );

                      },
                    ),
                  if (state is UploadPostLoadingState)
                    MyCircularProgressIndicator(),
                  if (cubit.postImage == null) MyHeightSizedBox(x: 380),
                  if (cubit.postImage != null) MyHeightSizedBox(x: 100),
                  if (cubit.postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Image(
                          width: 300,
                          height: 200,
                          image: FileImage(cubit.postImage!),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blue.withOpacity(.6),
                          child: IconButton(
                            onPressed: () {
                              cubit.cancelPostImg();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  MyHeightSizedBox(x: 20),
                  MyElevetedButton(
                    height: 50,
                    width: double.maxFinite,
                    color: Colors.white.withOpacity(.6),
                    widget: const Icon(
                      Icons.image,
                      color: Colors.deepPurple,
                    ),
                    function: () {
                      cubit.pickPostImage();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
