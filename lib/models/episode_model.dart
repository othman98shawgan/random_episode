import 'image_model.dart';

class Episode {
  int? id;
  String? name;
  int? season;
  int? number;
  Image? image;
  String? summary;
  String? airdate;

  Episode({
    this.id,
    this.name,
    this.season,
    this.number,
    this.image,
    this.summary,
    this.airdate,
  });

  Episode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    season = json["season"];
    number = json['number'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
    airdate = json['airdate'];
  }
}
