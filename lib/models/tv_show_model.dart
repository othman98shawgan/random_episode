import 'package:random_episode/models/season_model.dart';

import 'image_model.dart';

class TvShow {
  int? id;
  String? name;
  Image? image;
  String? summary;
  String? premiered;
  String? ended;

  TvShow({
    this.id,
    this.name,
    this.image,
    this.summary,
    this.premiered,
    this.ended,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) => _showFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image?.toJson();
    data['summary'] = summary;
    data['premiered'] = premiered;
    data['ended'] = ended;
    return data;
  }
}

_showFromJson(Map<String, dynamic> json) {
  return TvShow(
    id: json['id'],
    name: json['name'],
    image: json['image'] != null ? Image.fromJson(json['image']) : null,
    summary: json['summary'],
    premiered: json['premiered'],
    ended: json['ended'],
  );
}
