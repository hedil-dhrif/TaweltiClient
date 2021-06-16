class General {
  int id;
  String type;
  int restaurantId;
  DateTime createdAt;
  DateTime updatedAt;

  General(
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
  factory General.fromJson(Map<String, dynamic> item) {
    return General(
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
