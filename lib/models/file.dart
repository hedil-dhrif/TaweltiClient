class File {
  int id;
  int restaurantId;
  String fileName;
  String url;

  File(
      {this.id,
        this.restaurantId,
        this.fileName,
        this.url,
       });
  Map<String, dynamic> toJson() {
    return {
      'filename': fileName,
      'RestaurantId':restaurantId,
      'url':url,
    };
  }
  factory File.fromJson(Map<String, dynamic> item) {
    return File(
      id: item['id'],
      fileName: item['filename'],
      url: item['url'],
      restaurantId: item['RestaurantId'],

    );
  }
}
