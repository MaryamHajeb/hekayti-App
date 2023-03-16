class TechersModel {
  dynamic id, name;

  TechersModel({required this.id, required this.name});

  factory TechersModel.fromJson(Map<String, dynamic> category) {
    return TechersModel(id: category['id'], name: category['name']);
  }

  TechersModel fromJson(Map<String, dynamic> json) {
    return TechersModel.fromJson(json);
  }

  factory TechersModel.init() {
    return TechersModel(
      id: '',
      name: '',

    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<TechersModel> data = [];
    jsonList.forEach((post) {
      data.add(TechersModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
