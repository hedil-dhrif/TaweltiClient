class RestaurantTable {
  int id;
  int code;
  String nbCouverts;
  int zoneId;
  int tolerance;
  String description;
  int etat;
  double x;
  double y;
  DateTime createdAt;
  DateTime updatedAt;

  RestaurantTable({
    this.id,
    this.code,
    this.nbCouverts,
    this.zoneId,
    this.tolerance,
    this.description,
    this.x,
    this.etat,
    this.y,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'tolerance': tolerance,
      'nbCouverts': nbCouverts,
      'x': x,
      'y': y
    };
  }

  factory RestaurantTable.fromJson(Map<String, dynamic> item) {
    return RestaurantTable(
      id: item['id'],
      code: item['code'],
      nbCouverts: item['nbCouverts'],
      description: item['description'],
      zoneId: item['ZoneId'],
      etat: item['etat'],
      tolerance: item['tolerance'],
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt: item['updatedAt'] != null
          ? DateTime.parse(item['updatedAt'])
          : null,
    );
  }
}
