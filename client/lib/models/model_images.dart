class ModelBodyImages {
  String? id;
  String? name;
  String? url;
  String? issuesId;
  String? usersId;

  ModelBodyImages({
    this.id,
    this.name,
    this.url,
    this.issuesId,
    this.usersId,
  });

  ModelBodyImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    issuesId = json['issuesId'];
    usersId = json['usersId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    data['issuesId'] = issuesId;
    data['usersId'] = usersId;
    return data;
  }
}
