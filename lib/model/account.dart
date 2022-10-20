import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  String id; //ユーザーを特定するためのID
  String name;
  String imagePath; //プロフィール画像
  String selfIntroduction;
  String userId;
  Timestamp? createdTime;
  Timestamp? updatedTime;
  //Firestoreにユーザーを追加

  Account(
      {this.id = '',
      this.name = '',
      this.imagePath = '',
      this.selfIntroduction = '',
      this.userId = '',
      this.createdTime,
      this.updatedTime});
}
