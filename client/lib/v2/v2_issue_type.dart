class V2IssueType {
  V2IssueType();
  late String id;
  late String name;

  // a1 do not remove this line
  V2IssueType.bug() {
    id = '1';
    name = 'bug';
  }
  V2IssueType.feature() {
    id = '2';
    name = 'feature';
  }
  V2IssueType.improvement() {
    id = '3';
    name = 'improvement';
  }
  V2IssueType.task() {
    id = '4';
    name = 'task';
  }
  V2IssueType.request() {
    id = '5';
    name = 'request';
  }
  V2IssueType.other() {
    id = '6';
    name = 'other';
  }

  Map val() => {
        'id': id,
        'name': name,
      };

  // a1 do not remove this line
  List<V2IssueType> get all => [
        V2IssueType.bug(),
        V2IssueType.feature(),
        V2IssueType.improvement(),
        V2IssueType.task(),
        V2IssueType.request(),
        V2IssueType.other(),
      ];
}
