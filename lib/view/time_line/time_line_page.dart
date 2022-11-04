import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter_demo_app/utils/firestore/posts.dart';
import 'package:twitter_demo_app/utils/firestore/users.dart';
import '../../model/account.dart';
import '../../model/post.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  TextEditingController videoController = TextEditingController();
  File? image;
  File? video;

  // ImageProvider getImage() {
  //   if (image == null) {
  //     return NetworkImage();
  //   } else {
  //     return FileImage(image!);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'タイムライン',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        //bodyと同じ色を指定するコード
        elevation: 2,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: PostFirestore.posts
              .orderBy('created_time', descending: true)
              .snapshots(),
          builder: (context, postSnapshot) {
            if (postSnapshot.hasData) {
              List<String> postAccountIds = [];
              postSnapshot.data!.docs.forEach((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                if (!postAccountIds.contains(data['post_account_id'])) {
                  postAccountIds.add(data['post_account_id']);
                }
              });
              return FutureBuilder<Map<String, Account>?>(
                  future: UserFirestore.getPostUserMap(postAccountIds),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasData &&
                        userSnapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemCount: postSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data =
                                postSnapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            Post post = Post(
                              id: postSnapshot.data!.docs[index].id,
                              content: data['content'],
                              postAccountId: data['post_account_id'],
                              createdTime: data['created_time'],
                              videoPath: data['video_path'],
                            );
                            Account postAccount = userSnapshot.data![
                                post.postAccountId]!; //IDにひも付いた投稿のデータを格納？
                            return Container(
                              decoration: BoxDecoration(
                                  border: index == 0
                                      ? Border(
                                          //indexが０だったら
                                          top: BorderSide(
                                              color: Colors.grey, width: 0),
                                          bottom: BorderSide(
                                              color: Colors.grey, width: 0),
                                        )
                                      : Border(
                                          //indexが1以上だったら
                                          bottom: BorderSide(
                                              color: Colors.grey, width: 0),
                                        )),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    foregroundImage:
                                        NetworkImage(postAccount.imagePath),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    postAccount.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '@${postAccount.userId}',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                              Text(DateFormat('M/d/yy').format(
                                                  post.createdTime!.toDate()))
                                            ],
                                          ),
                                          Text(post.content),
                                          // image!.path == null
                                          //     ? Container()
                                          //     :
                                          Container(
                                            height: 270,
                                            width: 360,
                                            child: Image(
                                                image: NetworkImage(
                                                    post.videoPath)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      print('エラー:usersnapshot');
                      return Container(child: Text('111'),);
                    }
                  });
            } else {
              print('エラー:postsnapshot');
              return Container();
            }
          }),
    );
  }
}
