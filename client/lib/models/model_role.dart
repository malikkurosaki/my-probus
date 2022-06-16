class ModelRole {
  late String id;
  late String name;

  ModelRole.user() {
    id = "1";
    name = "user";
  }
  ModelRole.leader() {
    id = "2";
    name = "leader";
  }
  ModelRole.moderator() {
    id = "3";
    name = "moderator";
  }
  ModelRole.admin() {
    id = "4";
    name = "admin";
  }
  ModelRole.superadmin() {
    id = "5";
    name = "superadmin";
  }
}
