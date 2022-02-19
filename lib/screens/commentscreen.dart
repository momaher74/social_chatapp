// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:socialapp/cubit/appcubit.dart';
// import 'package:socialapp/cubit/appstates.dart';
// import 'package:socialapp/helpers/methods.dart';
//
// class CommentScreen extends StatelessWidget {
//   const CommentScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var cubit = AppCubit.get(context);
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Scaffold(
//           body: Column(
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.all(12),
//                     width: 70,
//                     height: 70,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.blue, width: 2),
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: NetworkImage(
//                           post['profileImg'].toString(),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         post['name'],
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       MyHeightSizedBox(
//                         x: 5,
//                       ),
//                       Text(
//                         post['date'],
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
