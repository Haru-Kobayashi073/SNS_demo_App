import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter_demo_app/model/post.dart';
import 'package:twitter_demo_app/utils/authentication.dart';
import 'package:twitter_demo_app/utils/firestore/posts.dart';
import 'package:twitter_demo_app/utils/firestore/users.dart';
import 'package:twitter_demo_app/view/account/edit_account_page.dart';
import '../../model/account.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Account myAccount = Authentication.myAccount!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  foregroundImage:
                                      NetworkImage(myAccount.imagePath),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      myAccount.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '@${myAccount.userId}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            OutlinedButton(
                                onPressed: () async {
                                  var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditAccountPage()));
                                  if (result == true) {
                                    setState(() {
                                      myAccount = Authentication.myAccount!;
                                    });
                                  }
                                },
                                child: Text('編集')),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(myAccount.selfIntroduction),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                      color: Colors.blue,
                      width: 3,
                    ))),
                    child: Text(
                      '投稿',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: UserFirestore.users
                            .doc(myAccount.id)
                            .collection('my_posts')
                            .orderBy('created_time', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<String> mypostIds = List.generate(
                                snapshot.data!.docs.length, (index) {
                              return snapshot.data!.docs[index].id;
                            });
                            return FutureBuilder<List<Post>?>(
                                future:
                                    PostFirestore.getPostsFromIds(mypostIds),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          Post post = snapshot.data![index];
                                          return Container(
                                            decoration: BoxDecoration(
                                                border: index == 0
                                                    ? Border(
                                                        top: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0),
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0),
                                                      )
                                                    : Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0),
                                                      )),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  radius: 22,
                                                  foregroundImage: NetworkImage(
                                                      myAccount.imagePath),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  myAccount
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  '@${myAccount.userId}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(DateFormat(
                                                                    'M/d/yy')
                                                                .format(post
                                                                    .createdTime!
                                                                    .toDate()))
                                                          ],
                                                        ),
                                                        Text(post.content),
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
                                    return Container();
                                  }
                                });
                          } else {
                            return Container();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
