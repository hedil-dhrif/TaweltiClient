class User {
  int id;
  String first_name;
  String last_name;
  String email;
  String password;
  String resetLink;
  String phone;
  //int RestaurantId;
  DateTime createdAt;
  DateTime updatedAt;

  User(
      {this.id,
      this.first_name,
      this.last_name,
      this.email,
      this.password,
      this.resetLink,
      this.phone,
      this.createdAt,
      this.updatedAt});
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "password": password,
      "resetLink": resetLink,
      "phone": phone,
    };
  }

  factory User.fromJson(Map<String, dynamic> item) {
    return User(
      id: item['id'],
      first_name: item['first_name'],
      last_name: item['last_name'],
      email: item['email'],
      password: item['password'],
      phone: item['phone'],
      resetLink: item['resetLink'],
      createdAt: DateTime.parse(item['createdAt']),
      updatedAt:
          item['updatedAt'] != null ? DateTime.parse(item['updatedAt']) : null,
    );
  }
}
