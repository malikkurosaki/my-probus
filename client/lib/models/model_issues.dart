class ModelBodyIssues {
  String? id;
  String? idx;
  String? name;
  String? des;
  String? issueTypesId;
  String? issueStatusesId;
  String? clientsId;
  String? productsId;
  String? createdAt;
  String? updatedAt;
  String? usersId;
  String? issuePrioritiesId;
  String? departementsId;

  ModelBodyIssues({
    this.id,
    this.idx,
    this.name,
    this.des,
    this.issueTypesId,
    this.issueStatusesId,
    this.clientsId,
    this.productsId,
    this.createdAt,
    this.updatedAt,
    this.usersId,
    this.issuePrioritiesId,
    this.departementsId,
  });

  ModelBodyIssues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idx = json['idx'];
    name = json['name'];
    des = json['des'];
    issueTypesId = json['issueTypesId'];
    issueStatusesId = json['issueStatusesId'];
    clientsId = json['clientsId'];
    productsId = json['productsId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    usersId = json['usersId'];
    issuePrioritiesId = json['issuePrioritiesId'];
    departementsId = json['departementsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['idx'] = idx;
    data['name'] = name;
    data['des'] = des;
    data['issueTypesId'] = issueTypesId;
    data['issueStatusesId'] = issueStatusesId;
    data['clientsId'] = clientsId;
    data['productsId'] = productsId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['usersId'] = usersId;
    data['issuePrioritiesId'] = issuePrioritiesId;
    data['departementsId'] = departementsId;
    return data;
  }
}
