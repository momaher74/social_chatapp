import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:socialapp/cubit/appcubit.dart';
import 'package:socialapp/cubit/appstates.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: ScrollAppBar(
            controller: ScrollController(), // Note the controller here
            title: Text(cubit.title[cubit.currentIndex]),
          ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: cubit.currentIndex,
            showElevation: true,
            itemCornerRadius: 24,
            curve: Curves.easeIn,
            onItemSelected: (index) {
              cubit.changeNavBar(index);
              print(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: const Icon(Icons.apps),
                title: const Text('Home'),
                activeColor: Colors.red,
                textAlign: TextAlign.center,
              ),
              // BottomNavyBarItem(
              //   icon: const Icon(Icons.post_add_sharp),
              //   title: const Text('Post'),
              //   activeColor: Colors.purpleAccent,
              //   textAlign: TextAlign.center,
              // ),
              BottomNavyBarItem(
                icon: const Icon(Icons.message),
                title: const Text(
                  'Messages',
                ),
                activeColor: Colors.pink,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
                activeColor: Colors.blue,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
