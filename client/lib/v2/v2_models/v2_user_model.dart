class Role {
  String id;
  String name;

  Role(this.id, this.name);

  factory Role.fromJson(Map < String, dynamic > json) {
    return Role(json["id"], json["name"]);
  }

  Map < String, dynamic > toJson() {
    Map < String, dynamic > data = new Map < String, dynamic > ();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}


class User {
  String? id;
  String? name;
  Role? role;


  User({this.id, this.name, this.role});

  factory User.fromJson(Map < String, dynamic > json) {
    return User(id:  json["id"],name:  json["name"],role:  Role.fromJson(json["Role"]));
  }

  Map < String, dynamic > toJson() {
    Map < String, dynamic > data = new Map < String, dynamic > ();
    data['id'] = this.id;
    data['name'] = this.name;
    data['Role'] = this.role;
    return data;
  }
}