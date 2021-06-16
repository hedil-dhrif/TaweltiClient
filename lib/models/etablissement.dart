class Etablissement {
  int id;
  String type;
  int restaurantId;
  DateTime createdAt;
  DateTime updatedAt;

  Etablissement(
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
  factory Etablissement.fromJson(Map<String, dynamic> item) {
    return Etablissement(
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
