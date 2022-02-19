import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/appcubit.dart';
import 'package:socialapp/cubit/appstates.dart';
import 'package:socialapp/helpers/methods.dart';
import 'package:socialapp/main.dart';

class ChatDetailsScreen extends StatelessWidget {
  ChatDetailsScreen({
    required this.name,
    required this.img,
    required this.receiverId,
  });

  String? name;

  String? img;
  String? receiverId;

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var messageController = TextEditingController();

    return Builder(
      builder: (BuildContext context) {
        cubit.recMessage(receiverId: receiverId);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(img.toString()),
                    ),
                  ),
                ],
                title: Text(name.toString()),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //if(state is RecMessageSuccessState)
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: cubit.messages.length,
                        itemBuilder: (context, index) {
                          if (receiverId == cubit.userModel!.uId) {
                            return receiveItem(
                              message: cubit.messages[index].text,
                            );
                          } else {
                            return sendItem(
                              message: cubit.messages[index].text,
                            );
                          }
                        },
                      ),
                    ),
                    if (cubit.chatImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Image(
                            height: 200,
                            image: FileImage(cubit.chatImage!),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.red,
                            child: IconButton(
                              onPressed: () {
                                cubit.cancelChatImg();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    MyHeightSizedBox(x: 14),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              labelText: 'enter message .. ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.pickChatImage();
                          },
                          icon: const Icon(Icons.camera_alt),
                          color: Colors.deepPurple,
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.sendMessage(
                              senderId: token,
                              receiverId: receiverId,
                              date: DateTime.now().toString(),
                              text: messageController.text,
                            );
                            messageController.clear();
                          },
                          icon:
                              const Icon(Icons.send, color: Colors.deepPurple),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

sendItem({required String message}) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.deepPurple),
      child: MyText(
        text: message,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}

receiveItem({required String message}) {
  return Align(
    alignment: Alignment.bottomLeft,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black54),
      child: MyText(
        text: message,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}
