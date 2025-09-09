import 'dart:convert';

class ImagensGatosModel {
  String? id;
  String? url;
  int? width;
  int? height;

  ImagensGatosModel({this.id, this.url, this.width, this.height});

  ImagensGatosModel copyWith({
    String? id,
    String? url,
    int? width,
    int? height,
  }) => ImagensGatosModel(
    id: id ?? this.id,
    url: url ?? this.url,
    width: width ?? this.width,
    height: height ?? this.height,
  );

  factory ImagensGatosModel.fromJson(String str) =>
      ImagensGatosModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImagensGatosModel.fromMap(Map<String, dynamic> json) =>
      ImagensGatosModel(
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "url": url,
    "width": width,
    "height": height,
  };
}
