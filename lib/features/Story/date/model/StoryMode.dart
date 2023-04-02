class StoryModel {
  dynamic id, name;

  StoryModel({required this.id, required this.name});

  factory StoryModel.fromJson(Map<String, dynamic> category) {
    return StoryModel(id: category['id'], name: category['name']);
  }

  StoryModel fromJson(Map<String, dynamic> json) {
    return StoryModel.fromJson(json);
  }

  factory StoryModel.init() {
    return StoryModel(
      id: '',
      name: '',

    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<StoryModel> data = [];
    jsonList.forEach((post) {
      data.add(StoryModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
