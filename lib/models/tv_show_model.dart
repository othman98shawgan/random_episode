import 'image_model.dart';

class TvShow {
  int? id;
  String? name;
  Image? image;
  String? summary;
  String? premiered;
  String? ended;

  TvShow({this.id, this.name, this.image, this.summary, this.premiered, this.ended});
  TvShow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    summary = json['summary'];
    premiered = json['premiered'];
    ended = json['ended'];
  }
}
