import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:socialapp/cubit/appcubit.dart';
import 'package:socialapp/cubit/appstates.dart';
import 'package:socialapp/helpers/methods.dart';
import 'package:socialapp/screens/editprofileimages.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var model = cubit.userModel;
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var currentPasswordController = TextEditingController();
    var newPasswordController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                MyHeightSizedBox(x: 20),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          image: NetworkImage(model!.coverImg.toString()),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.deepPurple,
                          child: IconButton(
                            onPressed: () {
                              push(context, const EditProfileImages());
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 3),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(model.profileImg.toString()),
                          ),
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.deepPurple,
                          child: IconButton(
                            onPressed: () {
                              push(context, const EditProfileImages());
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
                MyHeightSizedBox(x: 10),
                MyText(
                  text: model.name,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                MyHeightSizedBox(x: 5),
                MyText(
                  text: model.bio,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                MyHeightSizedBox(x: 20),
                if (cubit.edit == false)
                  MyElevetedButton(
                    height: 50,
                    width: double.maxFinite,
                    color: Colors.deepPurple,
                    widget: const Text('Edit Info '),
                    function: () {
                      cubit.changeEdit();
                    },
                  ),
                MyHeightSizedBox(x: 30),
                if (cubit.edit == true)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                            color: Colors.yellowAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: MyText(
                          text:
                              'you must enter the current password to confirm the edit ',
                          fontSize: 14,
                        ),
                      ),
                      MyHeightSizedBox(x: 20),
                      TextFormField(
                        controller: nameController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'not valid data';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'enter your new name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      MyHeightSizedBox(x: 12),
                      TextFormField(
                        controller: emailController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'not valid data';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'enter your new email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      MyHeightSizedBox(x: 12),
                      TextFormField(
                        controller: phoneController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'not valid data';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'enter your new phone',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      MyHeightSizedBox(x: 12),
                      TextFormField(
                        controller: bioController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'not valid data';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'enter your new bio',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      MyHeightSizedBox(x: 12),
                      TextFormField(
                        obscureText: true,
                        controller: currentPasswordController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'not valid data';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'enter your current password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      MyHeightSizedBox(x: 12),
                      TextFormField(
                        obscureText: true,
                        controller: newPasswordController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'not valid data';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'enter your new password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                MyHeightSizedBox(x: 20),
                if (cubit.edit == true && state is ! EditInfoLoadingState)
                  MyElevetedButton(
                    height: 50,
                    width: double.maxFinite,
                    color: Colors.deepPurple,
                    widget: const Text('Confirm Edit'),
                    function: () {
                      if (model.password == currentPasswordController.text) {
                        cubit.editInfo(
                          name: nameController.text == ''
                              ? model.name
                              : nameController.text,
                          email: emailController.text == ''
                              ? model.email
                              : emailController.text,
                          bio: bioController.text == ''
                              ? model.bio
                              : bioController.text,
                          password: newPasswordController.text == ''
                              ? model.password
                              : newPasswordController.text,
                          phone: phoneController.text == ''
                              ? model.phone
                              : phoneController.text,
                        );
                      } else {
                        Get.snackbar('error', 'please try again ',
                            backgroundColor: Colors.redAccent);
                      }
                    },
                  ),
                if(state is EditInfoLoadingState)
                  MyCircularProgressIndicator()
              ],
            ),
          ),
        );
      },
    );
  }
}
