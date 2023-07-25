class StoryModel {
  dynamic id,
      name,
      cover_photo,
      author,
      level,
      required_stars,
      stars,
      story_order,
      updated_at,
      download;

  StoryModel({
    required this.id,
    required this.cover_photo,
    required this.download,
    this.story_order,
    required this.updated_at,
    required this.author,
    required this.level,
    required this.required_stars,
    required this.name,
    this.stars,
  });

  factory StoryModel.fromJson(Map<String, dynamic> story) {
    return StoryModel(
        id: story['id'],
        cover_photo: story['cover_photo'],
        author: story['author'],
        level: story['level'],
        required_stars: story['required_stars'],
        name: story['name'],
        updated_at: story['updated_at'],
        download: story['download'],
        stars: story['stars'],
        story_order: story['story_order']);
  }

  StoryModel fromJson(Map<String, dynamic> json) {
    return StoryModel.fromJson(json);
  }

  factory StoryModel.init() {
    return StoryModel(
      id: '',
      name: '',
      updated_at: '',
      required_stars: '',
      level: '',
      author: '',
      cover_photo: '',
      stars: '',
      story_order: '',
      download: '',
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
        'name': name,
        'stars': stars,
        'story_order': story_order,
        'download': download,
        'updated_at': updated_at,
      };
}
