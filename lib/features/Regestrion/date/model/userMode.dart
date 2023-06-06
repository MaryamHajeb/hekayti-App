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

  factory UserModel.fromJson(Map<String, dynamic> category) {
    return UserModel(

      user_name: category['user_name'],
      email: category['email'],
      level: category['level'],
      character: category['character'],
      id: category['id'],
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
