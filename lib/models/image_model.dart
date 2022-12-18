class Image {
  final String medium;
  final String original;

  Image({required this.medium, required this.original});

  Image.fromJson(Map<String, dynamic> json)
      : medium = json['medium'],
        original = json['original'];

  Map<String, dynamic> toJson() => {
        'medium': medium,
        'original': original,
      };
}
