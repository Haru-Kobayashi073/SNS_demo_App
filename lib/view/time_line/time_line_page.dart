import 'package:flutter/material.dart';
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
      body: Container(),
    );
  }
}
/*ListView.builder(
          itemCount: postlist.length,
          itemBuilder: (context, index) {
            return Scaffold(
              body: Container(),
            );
          }),*/