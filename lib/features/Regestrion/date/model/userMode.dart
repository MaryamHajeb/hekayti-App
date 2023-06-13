class UserModel {
  dynamic id, user_name, email, level,character;

  UserModel(
      {
      required this.user_name,
      required this.email,
      required this.level,
      required this.character,
      required this.id

      });

  factory UserModel.fromJson(Map<String, dynamic> user) {
    return UserModel(

      user_name: user['user_name'],
      email : user['email'],
      level: user['level'],
      character: user['character'],
      id: user['id'],
    );
  }

  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  factory UserModel.init() {
    return UserModel(

      user_name: '',
      email: '',
      character: '',
      id: '',
      level: '',
    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<UserModel> data = [];
    jsonList.forEach((post) {
      data.add(UserModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': user_name,
        'email': email,
        'level': level,
        'character': character,
      };
}
