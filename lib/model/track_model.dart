class Track {
  final String id;
  final String title;
  final String description;
  final String audioUrl;

  Track({
    required this.id,
    required this.title,
    required this.description,
    required this.audioUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      audioUrl: json['audioUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'audioUrl': audioUrl,
    };
  }
}
