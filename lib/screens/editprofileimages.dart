import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/appcubit.dart';
import 'package:socialapp/cubit/appstates.dart';
import 'package:socialapp/helpers/methods.dart';

import 'homescreen.dart';

class EditProfileImages extends StatelessWidget {
  const EditProfileImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var model = cubit.userModel;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is EditProfileImgSuccessState ||
            state is EditProfileImgSuccessState ||
            state is GetUserSuccessState) {
          cubit.coverImage = null;
          cubit.profileImage = null;
          pushReplacement(context, const HomeScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('EditProfileImages'),
          ),
          body: Column(
            children: [
              MyHeightSizedBox(x: 20),
              if (state is EditProfileImgLoadingState ||
                  state is EditCoverImgLoadingState)
                const LinearProgressIndicator(
                  color: Colors.deepPurple,
                ),
              if (state is EditProfileImgLoadingState ||
                  state is EditCoverImgLoadingState)
                MyHeightSizedBox(x: 20),
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      if (cubit.coverImage == null)
                        Image(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          image: NetworkImage(model!.coverImg.toString()),
                        ),
                      if (cubit.coverImage != null)
                        Image(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          image: FileImage(cubit.coverImage!),
                        ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.deepPurple,
                        child: IconButton(
                          onPressed: () {
                            cubit.pickCoverImage();
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      if (cubit.profileImage == null)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 3),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(model!.profileImg.toString()),
                          ),
                        ),
                      if (cubit.profileImage != null)
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 3),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(cubit.profileImage!),
                          ),
                        ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.deepPurple,
                        child: IconButton(
                          onPressed: () {
                            cubit.pickProfileImage();
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              MyHeightSizedBox(x: 20),
              if (cubit.coverImage != null)
                MyElevetedButton(
                  color: Colors.deepPurple,
                  widget: const Text('Edit Cover image'),
                  function: () {
                    cubit.editCoverImg();
                  },
                ),
              if (cubit.profileImage != null)
                MyElevetedButton(
                  color: Colors.deepPurple,
                  widget: const Text('Edit Profile image'),
                  function: () {
                    cubit.editProfileImg();
                  },
                ),
              if (cubit.coverImage != null && cubit.profileImage != null)
                MyElevetedButton(
                  color: Colors.deepPurple,
                  widget: const Text('Edit images'),
                  function: () {
                    cubit.editCoverImg();
                    cubit.editProfileImg();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
