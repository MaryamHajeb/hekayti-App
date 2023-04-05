class MeadiaModel {
  dynamic id, page_no,story_id,photo,sound,text;

  MeadiaModel({

     this.id,
    required this.story_id,
    required this.photo,
    required this.sound,
    required this.text,
    required this.page_no,});

  factory MeadiaModel.fromJson(Map<String, dynamic> meadia) {
    return MeadiaModel(



        id: meadia['id'],
        story_id: meadia['story_id'],
        photo: meadia['photo'],
        sound: meadia['sound'],
        text: meadia['text'],

        page_no: meadia['page_no']);
  }

  MeadiaModel fromJson(Map<String, dynamic> json) {
    return MeadiaModel.fromJson(json);
  }

  factory MeadiaModel.init() {
    return MeadiaModel(
      id: '',
      page_no: '',
      text: '',
      sound: '',
      photo: '',
      story_id: '',


    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<MeadiaModel> data = [];
    jsonList.forEach((post) {
      data.add(MeadiaModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {

    'id': id,
    'text': text,
    'sound': sound,
    'photo': photo,
    'story_id': story_id,
    'page_no': page_no};
}
