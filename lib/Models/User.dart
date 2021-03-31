class User {
  String name, city, accessToken = '', id = '';

  User({
    this.name,
    this.city,
    this.accessToken,
    this.id
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      city: json["city"],
      accessToken: json["accessToken"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["city"] = city;
    map["accessToken"] = accessToken;
    map["id"] = id;
    return map;
  }
}