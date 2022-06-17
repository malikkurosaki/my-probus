class ModelBodyDiscussion {
  String? id;
  String? content;
  String? issuesId;
  String? usersId;
  String? createdAt;
  String? updatedAt;
  String? imagesId;

  ModelBodyDiscussion({
    this.id,
    this.content,
    this.issuesId,
    this.usersId,
    this.createdAt,
    this.updatedAt,
    this.imagesId,
  });

  ModelBodyDiscussion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    issuesId = json['issuesId'];
    usersId = json['usersId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    imagesId = json['imagesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['content'] = content;
    data['issuesId'] = issuesId;
    data['usersId'] = usersId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['imagesId'] = imagesId;
    return data;
  }
}
