class UsersModel {
  dynamic id, name;

  UsersModel({required this.id, required this.name});

  factory UsersModel.fromJson(Map<String, dynamic> category) {
    return UsersModel(id: category['id'], name: category['name']);
  }

  UsersModel fromJson(Map<String, dynamic> json) {
    return UsersModel.fromJson(json);
  }

  factory UsersModel.init() {
    return UsersModel(
      id: '',
      name: '',

    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<UsersModel> data = [];
    jsonList.forEach((post) {
      data.add(UsersModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
