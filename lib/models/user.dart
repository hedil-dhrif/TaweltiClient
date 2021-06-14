class User {
  int id;
  String username;
  String email;
  String password;
  String resetLink;
  String phone;
  //int RestaurantId;
  DateTime createdAt;
  DateTime updatedAt;

  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.resetLink,
      this.phone,
      this.createdAt,
      this.updatedAt});
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password,
      "resetLink": resetLink,
      "phone": phone,
    };
  }

  factory User.fromJson(Map<String, dynamic> item) {
    return User(
      id: item['id'],
      username: item['username'],
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
