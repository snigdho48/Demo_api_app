class ImageModel {
  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  ImageModel(
      {this.id,
      this.author,
      this.width,
      this.height,
      this.url,
      this.downloadUrl});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['author'] = author;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['download_url'] = downloadUrl;
    return data;
  }
}
