import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/message/message_bloc.dart';
import 'package:ideal_playground/models/chat_roam_model.dart';
import 'package:ideal_playground/models/user.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class ChatRoam extends StatefulWidget {
  final ChatRoamModel chatRoam;
  final UserModel user;

  const ChatRoam({Key? key, required this.chatRoam, required this.user} ) : super(key: key);

  @override
  State<ChatRoam> createState() => _ChatRoamState();
}

class _ChatRoamState extends State<ChatRoam> {
  final TextEditingController _searchController = TextEditingController();
  bool isTyping = false;
  get user => widget.user;
  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<MessageBloc, MessageState>(
    //   bloc: null,
    //   builder: (context, state) {
    //     if(state is ChatRoamInitial) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     if(state is ChatRoamLoading){
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     if(state is ChatRoamError){
    //       return const Center(
    //         child: Text("Something went wrong"),
    //       );
    //     }
    //     if(state is ChatRoamLoaded)
    //     return  Scaffold(
    //       appBar: AppBar(
    //         centerTitle: true,
    //         title: Row(
    //           children: [
    //             CircleAvatar(
    //               child: Image.network(''),
    //             ),
    //             Text("User name")
    //           ],
    //         ),
    //       ),
    //       body: SafeArea(
    //         child: Container(
    //             padding: const EdgeInsets.all(10),
    //             child:Column(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Expanded(
    //                   child: Container(),
    //                 ),
    //                 Flexible(
    //                   child: Row(
    //                     children: [
    //                       Expanded(
    //                         child: Container(
    //                           padding: const EdgeInsets.symmetric(horizontal: 8),
    //                           decoration: BoxDecoration(
    //                             color: AppColors.white,
    //                             borderRadius: BorderRadius.circular(15),
    //                           ),
    //                           child: TextField(
    //                               keyboardType: TextInputType.multiline,
    //                               onChanged: (value) {
    //                                 setState(() {
    //                                   isTyping = value.isNotEmpty;
    //                                 });
    //                               },
    //                               decoration: const InputDecoration(
    //                                 hintText: 'Type a message',
    //
    //                               ),
    //                               style: TextStyle(
    //                                 fontSize: 20,
    //                                 color: AppColors.black,
    //
    //                               )
    //                           ),
    //                         ),
    //                       ),
    //                       IconButton(
    //                         onPressed: () {},
    //                         icon:  Icon(Icons.send, color: isTyping ? AppColors.yellow : AppColors.grey,size: 35,),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //
    //             )
    //         ),
    //       ),
    //     );
    //     return const Center(
    //       child: Text("Something went wrong"),
    //     );
    //
    //   },
    // );
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(user.photoUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15,),
            Text(user.name),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(),
              ),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        setState(() {
                          isTyping = value.isNotEmpty;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type a message',

                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.black,

                      )
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon:  Icon(Icons.send, color: isTyping ? AppColors.yellow : AppColors.grey,size: 35,),
                ),
              ],
            ),
          ),
            ],

          )
        ),
      ),
    );
  }
}
