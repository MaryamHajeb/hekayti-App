class StoryModel {
  dynamic id, name,cover_photo,author,level,required_stars;

  StoryModel({

    required this.id,
    required this.cover_photo,
    required this.author,
    required this.level,
    required this.required_stars,
    required this.name,});

  factory StoryModel.fromJson(Map<String, dynamic> story) {
    return StoryModel(



        id: story['id'],
        cover_photo: story['cover_photo'],
        author: story['author'],
        level: story['level'],
        required_stars: story['required_stars'],

        name: story['name']);
  }

  StoryModel fromJson(Map<String, dynamic> json) {
    return StoryModel.fromJson(json);
  }

  factory StoryModel.init() {
    return StoryModel(
      id: '',
      name: '',
      required_stars: '',
      level: '',
      author: '',
      cover_photo: '',


    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<StoryModel> data = [];
    jsonList.forEach((post) {
      data.add(StoryModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {

    'id': id,
    'required_stars': required_stars,
    'level': level,
    'author': author,
    'cover_photo': cover_photo,
    'name': name};
}
