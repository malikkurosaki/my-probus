import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class Val {
  static final users = [].val('users').obs;
  static final user = {}.val("user").obs;
  static final token = "".val("token").obs;
  static final listContent = [].val("listContent").obs;
  static final listRequest = [].val('listRequest').obs;
  static final listTodo = [].val('listTodo').obs;

}
