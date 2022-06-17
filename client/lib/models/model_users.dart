class ModelBodyUsers {
  String? id;
  String? name;
  String? email;
  String? password;
  String? rolesId;

  ModelBodyUsers({
    this.id,
    this.name,
    this.email,
    this.password,
    this.rolesId,
  });

  ModelBodyUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    rolesId = json['rolesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['rolesId'] = rolesId;
    return data;
  }
}
