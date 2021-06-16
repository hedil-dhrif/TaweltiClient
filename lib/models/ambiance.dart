class Ambiance {
  int id;
  String type;
  int restaurantId;
  DateTime createdAt;
  DateTime updatedAt;

  Ambiance(
      {this.id,
        this.type,
        this.restaurantId,
        this.createdAt,
        this.updatedAt});
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'RestaurantId':restaurantId,
    };
  }
  factory Ambiance.fromJson(Map<String, dynamic> item) {
    return Ambiance(
      id: item['id'],
      type: item['type'],
      restaurantId: item['RestaurantId'],
      // dateDebut: DateTime.parse(item['dateDebut']),
      // dateFin:
      //     item['dateFin'] != null ? DateTime.parse(item['dateFin']) : null,
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt:
      item['updatedAt'] != null ? DateTime.parse(item['updatedAt']) : null,
    );
  }
}
