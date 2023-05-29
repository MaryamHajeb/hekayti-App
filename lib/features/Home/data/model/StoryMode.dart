class StoryModel {
  dynamic id, name,cover_photo,auther,level,required_star,stars;

  StoryModel({

     this.id,
    required this.cover_photo,
    required this.auther,
    required this.level,
    required this.required_star,
    required this.name,
     required this.stars,


    });

  factory StoryModel.fromJson(Map<String, dynamic> story) {
    return StoryModel(



        id: story['id'],
        cover_photo: story['coverphoto'],
        auther: story['auther'],
        level: story['level'],
        required_star: story['required_star'],
        name: story['name'],
        stars: story['start']

    );
  }

  StoryModel fromJson(Map<String, dynamic> json) {
    return StoryModel.fromJson(json);
  }

  factory StoryModel.init() {
    return StoryModel(
      id: '',
      name: '',
      required_star: '',
      level: '',
      auther: '',
      cover_photo: '',
      stars: '',


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
    'required_star': required_star,
    'level': level,
    'auther': auther,
    'coverphoto': cover_photo,
    'name': name,
    'start': stars,
  };
}
