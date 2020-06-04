class User {
  int id;
  String email;
  String name;
  String surname;

  User({
    this.id,
    this.email,
    this.name,
    this.surname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        surname: json['surname']);
  }
}
