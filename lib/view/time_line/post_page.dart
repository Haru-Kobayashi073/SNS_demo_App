import 'dart:io';

import 'package:flutter/material.dart';
import 'package:twitter_demo_app/model/account.dart';
import 'package:twitter_demo_app/model/post.dart';
import 'package:twitter_demo_app/utils/authentication.dart';
import 'package:twitter_demo_app/utils/firestore/posts.dart';
import 'package:twitter_demo_app/utils/function_utils.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Account myAccount = Authentication.myAccount!;
  TextEditingController contentController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  File? image;
  File? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '新規投稿',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: contentController,
            ),
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () async {
                var result = await FunctionUtils.getImageFromGallery();
                if (result != null) {
                  setState(() {
                    video = File(result.path);
                  });
                }
              },
              child: video == null
                  ? Container(
                      height: 270,
                      width: 360,
                      color: Color.fromARGB(255, 213, 210, 210),
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.white,
                        size: 100,
                      ))
                  : Container(
                      height: 270,
                      width: 360,
                      child: Image.file(video!, fit: BoxFit.cover),
                    ),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (contentController.text.isNotEmpty && video != null) {
                    var _result = await createPost(myAccount.id);
                    if (_result == true) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('投稿'))
          ],
        ),
      ),
    );
  }

  Future<dynamic> createPost(String uid) async {
    String videoPath = await FunctionUtils.uploadVideo(uid, video!);
    Post newPost = Post(
        content: contentController.text,
        postAccountId: Authentication.myAccount!.id,
        videoPath: videoPath);
    var _result = await PostFirestore.addPost(newPost);
    return _result;
  }
}
