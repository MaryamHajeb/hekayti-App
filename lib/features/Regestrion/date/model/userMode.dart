class UserModel {
  dynamic id, userName, email, token;

  UserModel(
      {
      required this.userName,
      required this.email,
      required this.token});

  factory UserModel.fromJson(Map<String, dynamic> category) {
    return UserModel(

      userName: category['userName'],
      email: category['email'],
      token: category['token'],
    );
  }

  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel.fromJson(json);
  }

  factory UserModel.init() {
    return UserModel(

      userName: '',
      email: '',
      token: '',
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
        'userName': userName,
        'email': email,
        'token': token,
      };
}
