import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/account.dart';
import '../../model/post.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({super.key});

  @override
  State<TimeLinePage> createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
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
      appBar: AppBar(
        title: Text(
          'タイムライン',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
      ),
      body: ListView.builder(
          itemCount: postlist.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                border: index == 0 ? Border(
                  top: BorderSide(color: Colors.grey, width: 0),
                  bottom: BorderSide(color: Colors.grey, width: 0),
                ) : Border(bottom: BorderSide(color: Colors.grey, width: 0),)
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    foregroundImage: NetworkImage(myAccount.imagePath),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    myAccount.name,style: TextStyle(
                                      fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      '@${myAccount.userId}',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                  ],
                                ),
                                Text(DateFormat('M/d/yy').format(postlist[index].createdTime!))
                            ],
                          ),
                          Text(postlist[index].content),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
