class BookWaitSeat {
  int id;
  int ids;
  String guestName;
  String confResv;
  String cancResv;
  int restaurantId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime debut;
  DateTime fin;
  int etat;


  BookWaitSeat(
      {this.id,
        this.etat,
        this.cancResv,
        this.confResv,
        this.debut,
        this.fin,
        this.ids,
        this.restaurantId,
        this.createdAt,
        this.updatedAt});
  // Map<String, dynamic> toJson() {
  //   return {
  //
  //     'RestaurantId':restaurantId,
  //   };
  // }
  factory BookWaitSeat.fromJson(Map<String, dynamic> item) {
    return BookWaitSeat(
      id: item['id'],
      ids: item['ids'],
      confResv: item['confResv'],
      etat: item['etat'],
      restaurantId: item['RestaurantId'],
      debut: DateTime.parse(item['debut']),
      fin: item['dateFin'] != null ? DateTime.parse(item['fin']) : null,
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt:
      item['updatedAt'] != null ? DateTime.parse(item['updatedAt']) : null,
    );
  }
}
