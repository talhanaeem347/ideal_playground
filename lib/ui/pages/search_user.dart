// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ideal_playground/bloc/message/message_bloc.dart';
// import 'package:ideal_playground/repositories/message_repository.dart';
// import 'package:ideal_playground/ui/pages/chat_roam.dart';
// import 'package:ideal_playground/ui/widgets/custom/my_input_field.dart';
// import 'package:ideal_playground/utils/constants/app_colors.dart';
//
// class SearchUser extends StatefulWidget {
//   final String userId;
//   final MessageRepository messageRepository;
//   final MessageBloc messageBloc;
//   const SearchUser({
//     Key? key,
//     required this.userId,
//     required this.messageRepository,
//     required this.messageBloc,
//   }) : super(key: key);
//
//   @override
//   State<SearchUser> createState() => _SearchUserState();
// }
//
// class _SearchUserState extends State<SearchUser> {
//   final TextEditingController _searchController = TextEditingController();
//   bool isSearching = false;
//   get _messageBloc => widget.messageBloc;
//   get _messageRepository => widget.messageRepository;
//   @override
//   void initState() {
//     // TODO: implement initState
//       super.initState();
//       _messageBloc.add(SearchMatchEvent(userId: widget.userId, searchKey: ''));
//   }
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return
//     Scaffold(
//       appBar: AppBar(
//         title: const Text("Search User"),
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               width: size.width,
//               height: size.height * 0.15,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: MyInputField(
//                           controllerText: _searchController,
//                           textInputType: TextInputType.text,
//                           isObscure: false,
//                           label: 'User Name',
//                           onChanged: (_) {
//                             setState(() {
//                               isSearching = !isSearching;
//                             });
//                           },
//                         ),
//                       ),
//
//
//                       Column(
//                         children: [
//                           IconButton(onPressed: (){
//                             showDialog(context: context, builder: (context){
//                               return AlertDialog(
//                                 title: const Text('Search'),
//                                 content: const Text('No such Match Found'),
//                                 actions: [
//                                   TextButton(onPressed: (){
//                                     Navigator.pop(context);
//                                   }, child: const Text('Ok'))
//                                 ],
//                               );
//                             });
//
//                           }, icon:
//                           Icon(Icons.search,
//                             color: AppColors.yellow, size: 40,),
//                           ),
//                           SizedBox(height: size.height * 0.03),
//                         ],
//                       ),
//
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                 stream: widget.messageRepository.getUsers(
//                   userId: widget.userId,
//                   searchKey: _searchController.text,
//                 ),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.data!.docs;
//                     if(documents.isEmpty) {
//                       return  Center(
//                         child: SizedBox(
//                             height: size.height * 0.2,
//                             child: Text('No user found', style: TextStyle(color: AppColors.white,fontSize: size.width *0.05),)),
//                       );
//                     }
//                     return ListView.builder(
//                       itemCount: documents.length,
//                       itemBuilder: (context, index) {
//                         final user = documents[index].data();
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                               decoration: BoxDecoration(
//                                 color: AppColors.grey,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: 30,
//                                         backgroundImage: NetworkImage(user['photoUrl']),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Text(user['name']),
//                                     ],
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       // Perform add friend action
//                                     },
//                                     icon: Icon(Icons.message_outlined,
//                                       color: AppColors.yellow,),
//                                   ),
//                                 ],
//                               )
//                           ),
//                         );
//
//
//                       },
//                     );
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     return const CircularProgressIndicator();
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_playground/bloc/user_search/search_user_bloc.dart';
import 'package:ideal_playground/repositories/search_user_repository.dart';
import 'package:ideal_playground/ui/pages/chat_roam.dart';
import 'package:ideal_playground/ui/widgets/custom/my_input_field.dart';
import 'package:ideal_playground/ui/widgets/page_turn.dart';
import 'package:ideal_playground/utils/constants/app_colors.dart';

class SearchUser extends StatefulWidget {
  final String userId;
  const SearchUser({super.key, required this.userId});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final TextEditingController _searchController = TextEditingController();
  late SearchUserBloc _searchUserBloc;
  final SearchUserRepository _searchUserRepository = SearchUserRepository();

  get _userId => widget.userId;

  @override
  void initState() {
    super.initState();
    _searchUserBloc =
        SearchUserBloc(searchUserRepository: _searchUserRepository);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<SearchUserBloc, SearchUserState>(
      bloc: _searchUserBloc,
      builder: (context, state) {
        if (state is SearchUserInitial) {
          _searchUserBloc
              .add(SearchUserFetchAll(userId: _userId));
          return Container(
            color: AppColors.scaffoldBackgroundColor,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SearchUserLoading) {
          return Container(
            color: AppColors.scaffoldBackgroundColor,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SearchUserLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Search User"),
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: size.width,
                    height: size.height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: MyInputField(
                                controllerText: _searchController,
                                textInputType: TextInputType.text,
                                isObscure: false,
                                label: 'User Name',
                                onChanged: (value){
                                  if(value.isEmpty) {
                                    _searchUserBloc.add(SearchUserFetchAll(userId: _userId));
                                  } else {
                                    _searchUserBloc.add(SearchUserFetch(query: value));
                                  }
                                }
                                ,
                                // onChanged: (_) {
                                  // setState(() {
                                  //   isSearching = !isSearching;
                                //   });
                                // },
                              ),
                            ),
                            Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Search'),
                                            content: const Text(
                                                'No such Match Found'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Ok'))
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    color: AppColors.yellow,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.03),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: state.users,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<
                                  QueryDocumentSnapshot<Map<String, dynamic>>>
                              documents = snapshot.data!.docs;
                          if (documents.isEmpty) {
                            return Center(
                              child: SizedBox(
                                  height: size.height * 0.2,
                                  child: Text(
                                    'No user found',
                                    style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: size.width * 0.05),
                                  )),
                            );
                          }
                          return ListView.builder(
                            itemCount: documents.length,
                            itemBuilder: (context, index) {
                              final user = documents[index].data();
                              print("user : $user");
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                  user['photoUrl']),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(user['name']),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Perform add friend action
                                            pageTurn( context: context, page: ChatRoam(userId: _userId,matchId: user[index].id,));
                                          },
                                          icon: Icon(
                                            Icons.message_outlined,
                                            color: AppColors.yellow,
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(
          color: AppColors.scaffoldBackgroundColor,
          child: const Center(
            child: Text("No Match"),
          ),
        );
      },
    );
  }
}
