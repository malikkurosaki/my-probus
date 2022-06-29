import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class V2Val{
  static final isMobile = false.val('isMobile').obs;
  static final hasLogin = false.val('hasLogin').obs;
  static final user = {}.val('user').obs;
}