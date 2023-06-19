class WebStoryModel{
  dynamic id, name,cover_photo,author,level,required_stars,updated_at,story_order,download;

  WebStoryModel({

   required  this.id,
    required this.cover_photo,
  required  this.story_order,
    required this.updated_at,
    required this.author,
    required this.level,
    required this.download,
    required this.required_stars,
    required this.name,



    });

  factory WebStoryModel.fromJson(Map<String, dynamic> story) {
    return WebStoryModel(



        id: story['id'],
        cover_photo: story['cover_photo'],
        author: story['author'],
        level: story['level'],
        required_stars: story['required_stars'],
        name: story['name'],
        updated_at: story['updated_at'],
      story_order: story['story_order'],
      download: story['download'],

    );
  }

  WebStoryModel fromJson(Map<String, dynamic> json) {
    return WebStoryModel.fromJson(json);
  }

  factory WebStoryModel.init() {
    return WebStoryModel(
      id: '',
      name: '',
      updated_at: '',
      required_stars: '',
      level: '',
      download: '',
      author: '',
      cover_photo: '',
      story_order: '',



    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<WebStoryModel> data = [];
    jsonList.forEach((post) {
      data.add(WebStoryModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {

    'id': id,
    'required_stars': required_stars,
    'level': level,
    'author': author,
    'cover_photo': cover_photo,
    'name': name,
    'download': download,
    'updated_at': updated_at,
    'story_order': story_order,

  };
}
