class ChartModel{
  dynamic id, page_no,story_id,photo,sound,text,text_no_dec,update_at,readed_text,accuracy_stars;

  ChartModel({

   required  this.id,
    required this.text,
    required this.accuracy_stars,
    required this.readed_text,
    required this.sound,
    required this.photo,
    required this.update_at,
    required this.page_no,
    required this.story_id,
    required this.text_no_dec,



    });

  factory ChartModel.fromJson(Map<String, dynamic> story) {
    return ChartModel(



        id: story['id'],
      text: story['text'],
      accuracy_stars: story['accuracy_stars'],

      readed_text: story['readed_text'],

      sound: story['sound'],
      photo: story['photo'],
      update_at: story['update_at'],
      page_no: story['page_no'],
      story_id: story['story_id'],
      text_no_dec: story['text_no_dec'],


    );
  }

  ChartModel fromJson(Map<String, dynamic> json) {
    return ChartModel.fromJson(json);
  }

  factory ChartModel.init() {
    return ChartModel(
      id: '',
      text: '',
      accuracy_stars: '',
      readed_text: '',
      sound: '',
      photo: '',
      update_at: '',
      page_no: '',
      story_id: '',
      text_no_dec: '',



    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<ChartModel> data = [];
    jsonList.forEach((post) {
      data.add(ChartModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'text': text,
    'accuracy_stars': accuracy_stars,
    'readed_text': readed_text,
    'sound': sound,
    'photo': photo,
    'page_no': page_no,
    'update_at': update_at,
    'story_id': story_id,
    'text_no_dec': text_no_dec,
  };
}
