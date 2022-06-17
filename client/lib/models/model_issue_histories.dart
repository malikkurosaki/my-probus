class ModelBodyIssueHistories {
  String? id;
  String? issuesId;
  String? note;
  String? usersId;
  String? createdAt;
  String? updatedAt;
  String? issueStatusesId;

  ModelBodyIssueHistories({
    this.id,
    this.issuesId,
    this.note,
    this.usersId,
    this.createdAt,
    this.updatedAt,
    this.issueStatusesId,
  });

  ModelBodyIssueHistories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    issuesId = json['issuesId'];
    note = json['note'];
    usersId = json['usersId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    issueStatusesId = json['issueStatusesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['issuesId'] = issuesId;
    data['note'] = note;
    data['usersId'] = usersId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['issueStatusesId'] = issueStatusesId;
    return data;
  }
}
