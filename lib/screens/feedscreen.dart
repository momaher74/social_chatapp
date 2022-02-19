import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/appcubit.dart';
import 'package:socialapp/cubit/appstates.dart';
import 'package:socialapp/helpers/methods.dart';
import 'package:socialapp/screens/postscreen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                MyHeightSizedBox(x: 14),
                InkWell(
                  onTap: () {
                    push(context, const PostScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    child: Card(
                      elevation: 5,
                      borderOnForeground: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        height: 70,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'What\'s in your mind ? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (cubit.allPosts.isNotEmpty)
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return postItem(
                          cubit, cubit.allPosts[index], index, context);
                    },
                    itemCount: cubit.allPosts.length,
                    shrinkWrap: true,
                  ),
                if (cubit.allPosts.isEmpty) MyCircularProgressIndicator()
              ],
            ),
          ),
        );
      },
    );
  }
}

postItem(cubit, post, index, context) => Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 8,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        post['profileImg'].toString(),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      post['name'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MyHeightSizedBox(
                      x: 5,
                    ),
                    Text(
                      post['date'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
            MyHeightSizedBox(x: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post['text'] != 'null')
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        post['text'],
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      )),
                if (post['text'] != 'null') MyHeightSizedBox(x: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image(
                    width: double.infinity,
                    height: 222,
                    image: NetworkImage(
                      post['postImg'].toString(),
                    ),
                  ),
                ),
              ],
            ),
            MyHeightSizedBox(x: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Divider(
                color: Colors.black,
                height: 3,
              ),
            ),
            MyHeightSizedBox(x: 12),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(.8),
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      // AppCubit.get(context).likePost(
                      //     postId: AppCubit.get(context).postId[index]);
                    },
                    child: Row(
                      children: [
                        const Text(
                          '1',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        MyWidthSizedBox(x: 15),
                        const Icon(
                          Icons.favorite_outline,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        const Text(
                          '0',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        MyWidthSizedBox(x: 15),
                        const Icon(
                          Icons.comment,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MyHeightSizedBox(x: 12)
          ],
        ),
      ),
    );
