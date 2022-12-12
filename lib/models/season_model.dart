import 'image_model.dart';

class Season {
  int? id;
  String? name;
  Image? image;
  String? summary;
  int? episodeOrder;
  String? premiereDate;
  String? endDate;

  Season({
    this.id,
    this.name,
    this.image,
    this.summary,
    this.episodeOrder,
    this.premiereDate,
    this.endDate,
  });

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
    episodeOrder = json['episodeOrder'];
    premiereDate = json['premiereDate'];
    endDate = json['endDate'];
  }
}
