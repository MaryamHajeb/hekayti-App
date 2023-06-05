class chartModel{
  dynamic id, name,cover_photo,percentage,stars;

  chartModel({

   required  this.id,
    required this.cover_photo,
    required this.percentage,
    required this.stars,

    required this.name,



    });

  factory chartModel.fromJson(Map<String, dynamic> story) {
    return chartModel(



        id: story['id'],
        cover_photo: story['cover_photo'],
        stars: story['stars'],

        name: story['name'],

      percentage: story['percentage'],

    );
  }

  chartModel fromJson(Map<String, dynamic> json) {
    return chartModel.fromJson(json);
  }

  factory chartModel.init() {
    return chartModel(
      id: '',
      name: '',
      percentage: '',
      cover_photo: '',
      stars: '',



    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<chartModel> data = [];
    jsonList.forEach((post) {
      data.add(chartModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'stars': stars,
    'percentage': percentage,
    'cover_photo': cover_photo,
    'name': name,
  };
}
