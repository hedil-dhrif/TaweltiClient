class Restaurant {
  int id;
  String NomResto;
  String description;
  String adresse;
  //bool etat;
  //String cuisine;
  DateTime temps_ouverture;
  DateTime temps_fermeture;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;

  Restaurant(
      {this.id,
      this.NomResto,
      this.adresse,
      this.description,
      //this.cuisine,
      //this.etat,
      this.userId,
      this.temps_fermeture,
      this.temps_ouverture,
      this.createdAt,
      this.updatedAt});
  Map<String, dynamic> toJson() {
    return {
      //"id":id,
      "NomResto": NomResto,
      "description":description,
      "adresse":adresse,
      "UserId":userId,
    };
  }

  factory Restaurant.fromJson(Map<String, dynamic> item) {
    return Restaurant(
      id: item['id'],
      NomResto: item['NomResto'],
      adresse: item['adresse'],
      description: item['Description'],
      userId: item['UserId'],
      //etat: item['etat'],
      //cuisine: item['cuisine'],
      temps_ouverture: DateTime.parse(item['temps_ouverture']),
      temps_fermeture: DateTime.parse(item['temps_fermeture']),
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt:
          item['updatedAt'] != null ? DateTime.parse(item['updatedAt']) : null,
    );
  }
}
