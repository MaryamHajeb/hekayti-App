class accuracyModel {
  dynamic id, accuracy_percentage,media_id,user_id;

  accuracyModel({
     this.id,
    required this.media_id,
    required this.user_id,
    required this.accuracy_percentage,});

  factory accuracyModel.fromJson(Map<String, dynamic> accuracy) {
    return accuracyModel(



        id: accuracy['id'],
        media_id: accuracy['media_id'],
        user_id: accuracy['photo'],

        accuracy_percentage: accuracy['accuracy_percentage']);
  }

  accuracyModel fromJson(Map<String, dynamic> json) {
    return accuracyModel.fromJson(json);
  }

  factory accuracyModel.init() {
    return accuracyModel(
      id: '',
      accuracy_percentage: '',
      user_id: '',
      media_id: '',
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

    'user_id': user_id,
    'media_id': media_id,
    'accuracy_percentage': accuracy_percentage};
}
