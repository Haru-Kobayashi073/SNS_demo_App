class Account {
  String id; //ユーザーを特定するためのID
  String name;
  String imagePath; //プロフィール画像
  String selfIntroduction;
  String userId;
  DateTime? createdTime;
  DateTime? updatedTime;

  Account(
      {this.id = '',
      this.name = '',
      this.imagePath = '',
      this.selfIntroduction = '',
      this.userId = '',
      this.createdTime,
      this.updatedTime});
}
