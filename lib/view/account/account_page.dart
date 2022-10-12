import 'package:flutter/material.dart';
import 'package:twitter_demo_app/main.dart';
import 'package:twitter_demo_app/model/account.dart';
import 'package:twitter_demo_app/model/post.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Account myAccount = Account(
    id: '1',
    name: 'Flutter ラボ',
    selfIntroduction: 'こんばんは',
    userId: 'Flutter_Lab',
    imagePath:
        'https://assets.st-note.com/production/uploads/images/58075596/profile_7d12166cbb91dd3ff25bbed3898bdd76.png?fit=bounds&format=jpeg&quality=85&width=330',
    createdTime: DateTime.now(),
    updatedTime: DateTime.now(),
  );

  List<Post> postlist = [
    Post(
      id: '1',
      content: '初めまして',
      postAccountId: '1',
      createdTime: DateTime.now(),
    ),
    Post(
      id: '2',
      content: '初めまして2回目',
      postAccountId: '1',
      createdTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.red.withOpacity(0.3),
                height: 200,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 32,
                              foregroundImage: NetworkImage(myAccount.imagePath),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myAccount.name, style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                Text(
                                  '@${myAccount.userId}',
                                  style: TextStyle(
                                    color: Colors.grey
                                    ),
                                  ),
                              ],
                            ),
                            OutlinedButton(onPressed: () {
                              
                            }, child: Text('編集')),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
