import 'track_model.dart';

class Program {
  final String? id;
  final String name;
  final String description;
  final String image;
  final List<Track> tracks;

  Program({
    this.id, 
    required this.name,
    required this.description,
    required this.image,
    required this.tracks,
  });

  
  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['_id'], 
      name: json['name'],
      description: json['description'],
      image: json['image'],
      tracks: (json['tracks'] as List)
          .map((trackJson) => Track.fromJson(trackJson))
          .toList(),
    );
  }

 
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'tracks': tracks.map((track) => track.toJson()).toList(),
    };
  }
}
