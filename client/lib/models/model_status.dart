class ModelStatus {
  late String id;
  late String name;

  ModelStatus.open() {
    id = "1";
    name = "open";
  }
  ModelStatus.reopened() {
    id = "10";
    name = "reopened";
  }
  ModelStatus.accepted() {
    id = "2";
    name = "accepted";
  }
  ModelStatus.rejected() {
    id = "3";
    name = "rejected";
  }
  ModelStatus.approved() {
    id = "4";
    name = "approved";
  }
  ModelStatus.decline() {
    id = "5";
    name = "decline";
  }
  ModelStatus.progress() {
    id = "6";
    name = "progress";
  }
  ModelStatus.resolved() {
    id = "7";
    name = "resolved";
  }
  ModelStatus.closed() {
    id = "8";
    name = "closed";
  }
  ModelStatus.pending() {
    id = "9";
    name = "pending";
  }
}
