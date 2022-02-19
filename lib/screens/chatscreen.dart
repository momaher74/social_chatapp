import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/appcubit.dart';
import 'package:socialapp/cubit/appstates.dart';
import 'package:socialapp/helpers/methods.dart';
import 'package:socialapp/screens/chatdetails.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    List userId = cubit.usersId;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              MyHeightSizedBox(x: 12),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var data = cubit.allUsers[index];
                  return InkWell(
                    onTap: () {
                      push(
                        context,
                        ChatDetailsScreen(
                          img: data.profileImg,
                          name: data.name,
                          receiverId: userId[index],
                        ),
                      );

                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.blue),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(data.profileImg),
                          ),
                          MyWidthSizedBox(x: 10),
                          MyText(text: data.name, fontSize: 24),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: cubit.allUsers.length,
              )
            ],
          ),
        );
      },
    );
  }
}
