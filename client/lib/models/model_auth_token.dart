class ModelBodyAuthToken {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? expiresAt;
  String? usersId;

  ModelBodyAuthToken({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.expiresAt,
    this.usersId,
  });

  ModelBodyAuthToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    expiresAt = json['expiresAt'];
    usersId = json['usersId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['expiresAt'] = expiresAt;
    data['usersId'] = usersId;
    return data;
  }
}
