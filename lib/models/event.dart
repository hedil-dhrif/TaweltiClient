class Event {
  int id;
  String nom;
  String category;
  String description;
  int restaurantId;
  DateTime dateDebut;
  DateTime dateFin;
  DateTime createdAt;
  DateTime updatedAt;

  Event(
      {this.id,
      this.nom,
      this.category,
      this.description,
      this.restaurantId,
      this.dateDebut,
      this.dateFin,
      this.createdAt,
      this.updatedAt});
  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      //'category':category,
      'description':description,
      // 'createdAt':dateDebut,
      // 'updatedAt':dateFin,
    };
  }
  factory Event.fromJson(Map<String, dynamic> item) {
    return Event(
      id: item['id'],
      nom: item['nom'],
      category: item['category'],
      description: item['Description'],
      restaurantId: item['restaurantId'],
      // dateDebut: DateTime.parse(item['dateDebut']),
      // dateFin:
      //     item['dateFin'] != null ? DateTime.parse(item['DateFin']) : null,
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt:
          item['updatedAt'] != null ? DateTime.parse(item['updatedAt']) : null,
    );
  }
}
