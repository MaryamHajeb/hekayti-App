class UserModel {
  dynamic id, user_name, email, level,character,update_at,password;

  UserModel(
      {
      required this.user_name,
      required this.email,
      required this.level,
      required this.character,
      required this.update_at,
      required this.password,
      required this.id

      });

  factory UserModel.fromJson(Map<String, dynamic> user) {
    return UserModel(

      user_name: user['user_name'],
      email : user['email'],
      level: user['level'],
      character: user['character'],
      update_at: user['update_at'],
      id: user['id'],
      password: user['password'],
    );
  }

  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  factory UserModel.init() {
    return UserModel(

      user_name: '',
      email: '',
      update_at: '',
      character: '',
      id: '',
      level: '',
      password: '',
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
        'update_at': update_at,
        'password': password,
      };
}
