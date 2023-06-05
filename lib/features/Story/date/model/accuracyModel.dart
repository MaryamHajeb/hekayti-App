class accuracyModel {
  dynamic id, accuracy_stars,media_id,readed_text,updated_at;

  accuracyModel({
     this.id,
    required this.media_id,
    required this.readed_text,
    required this.accuracy_stars,
    required this.updated_at,
  });

  factory accuracyModel.fromJson(Map<String, dynamic> accuracy) {
    return accuracyModel(



        id: accuracy['id'],
        media_id: accuracy['media_id'],
        readed_text: accuracy['photo'],

        accuracy_stars: accuracy['accuracy_stars'],
        updated_at: accuracy['updated_at'],
    );
  }

  accuracyModel fromJson(Map<String, dynamic> json) {
    return accuracyModel.fromJson(json);
  }

  factory accuracyModel.init() {
    return accuracyModel(
      id: '',
      accuracy_stars: '',
      readed_text: '',
      media_id: '',
      updated_at: '',
    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<accuracyModel> data = [];
    jsonList.forEach((post) {
      data.add(accuracyModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {

    'id': id,
    'updated_at':updated_at,
    'readed_text': readed_text,
    'media_id': media_id,
    'accuracy_stars': accuracy_stars};
}
