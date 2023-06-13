class CompletionModel {
  dynamic id, story_id,updated_at,stars,percentage;

  CompletionModel({

     required  this.id,
     required this.updated_at,
     required  this.percentage,
     required this.story_id,
     required this.stars,


    });

  factory CompletionModel.fromJson(Map<String, dynamic> story) {
    return CompletionModel(



        id: story['id'],
        updated_at: story['updated_at'],
        story_id: story['story_id'],
        stars: story['stars'],
        percentage: story['percentage']

    );
  }

  CompletionModel fromJson(Map<String, dynamic> json) {
    return CompletionModel.fromJson(json);
  }

  factory CompletionModel.init() {
    return CompletionModel(
      id: '',
      story_id: '',
      updated_at: '',
      stars: '',
      percentage: '',


    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<CompletionModel> data = [];
    jsonList.forEach((post) {
      data.add(CompletionModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {

    'id': id,
    'updated_at': updated_at,
    'story_id': story_id,
    'stars': stars,
    'percentage': percentage,

  };
}
