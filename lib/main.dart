import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:socialapp/cubit/appcubit.dart';
import 'package:socialapp/cubit/observer.dart';
import 'package:socialapp/helpers/sharedpref.dart';
import 'package:socialapp/screens/homescreen.dart';
import 'package:socialapp/screens/signinscreen.dart';

import 'cubit/appstates.dart';

String? uId;
String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  token = uId;
  print(uId.toString());
  BlocOverrides.runZoned(
    () => runApp(MyApp(
      uId: uId,
    )),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.uId}) : super(key: key);
  String? uId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (BuildContext context) => AppCubit()
        ..getUser()
        ..getPosts()
        ..getAllUsers(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
                  color: Colors.deepPurple,
                  size: 30,
                ),
                elevation: 5,
                color: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            home: uId == null ? const LoginScreen() : const HomeScreen(),
          );
        },
      ),
    );
  }
}
