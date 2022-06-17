class ModelBodyRoles {
  String? id;
  String? name;
  String? description;

  ModelBodyRoles({
    this.id,
    this.name,
    this.description,
  });

  ModelBodyRoles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
