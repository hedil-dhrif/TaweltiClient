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
  int userId;
  String random;
  String other;

  BookWaitSeat(
      {this.id,
      this.etat,
      this.cancResv,
      this.confResv,
      this.debut,
      this.fin,
      this.ids,
      this.guestName,
      this.restaurantId,
      this.createdAt,
        this.other,
      this.userId, this.random,
      this.updatedAt});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ids':ids,
      'confResv': confResv,
      'cancResv': cancResv,
      'etat': etat,
      'debut': debut.toIso8601String(),
      'fin': fin.toIso8601String(),
      'RestaurantId': restaurantId,
      'guestName': guestName,
      'UserId': userId,
      'random':random,
      'other':other,
    };
  }

  factory BookWaitSeat.fromJson(Map<String, dynamic> item) {
    return BookWaitSeat(
      id: item['id'],
      ids: item['ids'],
      confResv: item['confResv'],
      etat: item['etat'],
      userId: item['UserId'],
      guestName: item['guestName'],
      restaurantId: item['RestaurantId'],
      debut: DateTime.parse(item['debut']),
      fin: DateTime.parse(item['fin']),
      createdAt: DateTime.parse(item['createdAt']),
      random: item['random'],
      other: item['other'],
      updatedAt:
          item['updatedAt'] != null ? DateTime.parse(item['updatedAt']) : null,
    );
  }
}
