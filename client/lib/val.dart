import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class Val {
  static final users = [].val('users').obs;
  static final user = {}.val("user").obs;
  static final token = "".val("token").obs;
  static final listContent = [].val("listContent").obs;
  static final listRequest = [].val('listRequest').obs;
  static final listTodo = [].val('listTodo').obs;

  static final clients = [].val("clients").obs;
  static final products = [].val("products").obs;
  static final positions = [].val("positions").obs;
  static final departements = [].val("departements").obs;
  static final roles = [].val("roles").obs;
  static final issueTypes = [].val("issuesTypes").obs;
  static final issuePriorities = [].val("issuePriorities").obs;
  static final issues = [].val("issues").obs;

}
