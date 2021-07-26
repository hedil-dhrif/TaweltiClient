class RestaurantTable {
  int id;
  int ids;
  //int code;
  int nbCouverts;
  int zoneId;
  int salleId;
  int restaurantId;
  int tolerance;
  String description;
  int etat;
  String x;
  String y;
  String classIdTable;
  String typeTable;
  DateTime dateDebut;
  DateTime dateFin;
  DateTime createdAt;
  DateTime updatedAt;
  // String class1;
  // String class2;
  // String text;
  // DateTime heureDebut;
  // DateTime heureFin;
  RestaurantTable({
    this.id,
    this.ids,
   // this.code,
    this.nbCouverts,
    this.zoneId,
    this.salleId,
    this.tolerance,
    this.description,
    this.x,
    this.etat,
    this.y,
    // this.class1,
    // this.class2,
    this.restaurantId,
    //this.text,
    this.classIdTable,
    this.typeTable,
    // this.heureDebut,
    // this.heureFin,
    this.dateDebut,
    this.dateFin,
    this.createdAt,
    this.updatedAt,
  });

  // Map<String, dynamic> toJson() {
  //   return {
  //     'code': code,
  //     'tolerance': tolerance,
  //     'nbCouverts': nbCouverts,
  //     'x': x,
  //     'y': y
  //   };
  // }

  factory RestaurantTable.fromJson(Map<String, dynamic> item) {
    return RestaurantTable(
      description: item['Description']!=null?item['Description']:null,
      etat:  item['etat'] != null
          ? item['etat']
          : null,
      ids: item['ids'],
      id: item['id'],
      tolerance: item['tolerance']!= null?item['tolerance']:null,
      typeTable: item['typeTable']!= null?item['typeTable']:null,
      classIdTable: item['classIdtable']!= null?item['classIdtable']:null,
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt: item['updatedAt'] != null
          ? DateTime.parse(item['updatedAt'])
          : null,
      restaurantId: item['RestaurantId'],
      zoneId: item['ZoneId']!= null?item['ZoneId']:null,
      y: item['top'],
      x: item['left'],
      nbCouverts: item['tableNbrPx'],
      dateDebut:DateTime.parse(item['dateDebut']),
      dateFin:DateTime.parse(item['dateFin']),
      salleId: item['SalleId'],
      // heureDebut:DateTime.parse(item['heureDebut']),
      // heureFin:DateTime.parse(item['heureFin']),
      // class1: item['class'],
      // class2: item['class2'],
      // text: item['text'],
      // code: item['numero'],

    );
  }
}
