class Reservation {
  int id;
  int nbPersonne;
  String nomPersonne;
  int etat;
  String dateReservation;
  String heureReservation;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  int tableId;
  int restaurantId;

  Reservation(
      {this.id,
        this.etat,
        this.nbPersonne,
        this.nomPersonne,
      this.dateReservation,
      this.heureReservation,
        this.createdAt,
        this.updatedAt,
      this.userId,
      this.restaurantId,
      this.tableId});

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'nbPersonne':nbPersonne,
      'nomPersonne':nomPersonne,
      'etat':etat,
      'heureReservation':heureReservation,
      //'dateReservation':dateReservation,
      'UserId':userId,
      'RestaurantId':restaurantId,
      'TableId':tableId,
    };
  }
  factory Reservation.fromJson(Map<String, dynamic> item) {
    return Reservation(
      id: item['id'],
      nbPersonne: item['nbPersonne'],
      nomPersonne: item['nomPersonne'],
      etat: item['etat'],
      heureReservation: item['heureReservation'],
      dateReservation: item['DateReservation'],
      userId: item['UserId'],
      restaurantId: item['RestaurantId'],
      tableId: item['TableId'],
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt:
      item['updatedAt'] != null ? DateTime.parse(item['updatedAt']) : null,
    );
  }
}
