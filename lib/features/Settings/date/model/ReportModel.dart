class ReportModel {
  dynamic id, name,cover_photo,stars,percentage;

  ReportModel({

     required  this.id,
     required this.cover_photo,
     required  this.percentage,
     required this.name,
     required this.stars,


    });

  factory ReportModel.fromJson(Map<String, dynamic> story) {
    return ReportModel(



        id: story['id'],
        cover_photo: story['cover_photo'],

        name: story['name'],

        stars: story['stars'],
        percentage: story['percentage']

    );
  }

  ReportModel fromJson(Map<String, dynamic> json) {
    return ReportModel.fromJson(json);
  }

  factory ReportModel.init() {
    return ReportModel(
      id: '',
      name: '',
      cover_photo: '',
      stars: '',
      percentage: '',


    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<ReportModel> data = [];
    jsonList.forEach((post) {
      data.add(ReportModel.fromJson(post));
    });
    return data;
  }

  Map<String, dynamic> toJson() => {

    'id': id,
    'cover_photo': cover_photo,
    'name': name,
    'stars': stars,
    'percentage': percentage,

  };
}
