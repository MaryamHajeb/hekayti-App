class StoryModel {
  dynamic id, name,cover_photo,auther,level,required_stars,stars,story_order;

  StoryModel({

     this.id,
    required this.cover_photo,
    required this.story_order,
    required this.auther,
    required this.level,
    required this.required_stars,
    required this.name,
     required this.stars,


    });

  factory StoryModel.fromJson(Map<String, dynamic> story) {
    return StoryModel(



        id: story['id'],
        cover_photo: story['cover_photo'],
        auther: story['auther'],
        level: story['level'],
        required_stars: story['required_stars'],
        name: story['name'],
        stars: story['stars'],
        story_order: story['story_order']

    );
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
      auther: '',
      cover_photo: '',
      stars: '',
      story_order: '',


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
    'auther': auther,
    'cover_photo': cover_photo,
    'name': name,
    'stars': stars,
    'story_order': story_order,
  };
}
