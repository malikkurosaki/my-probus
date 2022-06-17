class ModelBodyIssuePriorities {
  String? id;
  String? name;
  String? value;
  String? des;

  ModelBodyIssuePriorities({
    this.id,
    this.name,
    this.value,
    this.des,
  });

  ModelBodyIssuePriorities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    des = json['des'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    data['des'] = des;
    return data;
  }
}
