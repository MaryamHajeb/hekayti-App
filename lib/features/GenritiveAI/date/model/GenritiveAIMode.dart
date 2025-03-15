class GenritiveAIMode {
  dynamic id, story_id, updated_at, stars, percentage;

  GenritiveAIMode({
    this.id,
    required this.updated_at,
    required this.percentage,
    required this.story_id,
    required this.stars,
  });

  factory GenritiveAIMode.fromJson(Map<String, dynamic> story) {
    return GenritiveAIMode(
        id: story['id'],
        updated_at: story['updated_at'],
        story_id: story['story_id'],
        stars: story['stars'],
        percentage: story['percentage']);
  }

  GenritiveAIMode fromJson(Map<String, dynamic> json) {
    return GenritiveAIMode.fromJson(json);
  }

  factory GenritiveAIMode.init() {
    return GenritiveAIMode(
      id: '',
      story_id: '',
      updated_at: '',
      stars: '',
      percentage: '',
    );
  }

  fromJsonList(List<dynamic> jsonList) {
    List<GenritiveAIMode> data = [];
    jsonList.forEach((post) {
      data.add(GenritiveAIMode.fromJson(post));
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
