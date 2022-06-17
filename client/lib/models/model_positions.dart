class ModelBodyPositions {
  String? id;
  String? name;
  String? departementsId;

  ModelBodyPositions({
    this.id,
    this.name,
    this.departementsId,
  });

  ModelBodyPositions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    departementsId = json['departementsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['departementsId'] = departementsId;
    return data;
  }
}
