class StoryMediaModel {
  dynamic id, page_no, story_id, image, audio, text, updated_at, text_no_desc;

  StoryMediaModel({
    this.id,
    required this.story_id,
    required this.image,
    required this.audio,
    required this.text,
    required this.text_no_desc,
    required this.updated_at,
    required this.page_no,
  });

  factory StoryMediaModel.fromJson(Map<String, dynamic> meadia) {
    return StoryMediaModel(
        id: meadia['id'],
        story_id: meadia['story_id'],
        updated_at: meadia['updated_at'],
        image: meadia['image'],
        audio: meadia['audio'],
        text: meadia['text'],
        text_no_desc: meadia['text_no_desc'],
        page_no: meadia['page_no']);
  }

  StoryMediaModel fromJson(Map<String, dynamic> json) {
    return StoryMediaModel.fromJson(json);
  }

  factory StoryMediaModel.init() {
    return StoryMediaModel(
      id: '',
      page_no: '',
      text: '',
      updated_at: '',
      audio: '',
      text_no_desc: '',
      image: '',
      story_id: '',
    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<StoryMediaModel> data = [];
    jsonList.forEach((post) {
      data.add(StoryMediaModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'audio': audio,
        'image': image,
        'updated_at': updated_at,
        'text_no_desc': text_no_desc,
        'story_id': story_id,
        'page_no': page_no
      };
}
