import 'package:get/get.dart';
import 'package:kindergarten/core/services/database.dart';
import 'package:kindergarten/ui/login/login_layout.dart';
import 'package:kindergarten/utils/cache_manager.dart';

class SettingsViewModel extends GetxController with CacheManager {
  late DatabaseHelper _database;
  final phoneNumber = "".obs;
  @override
  void onInit() async {
    super.onInit();
    _database = DatabaseHelper();
    await _database.initDatabase();
    var x = await _database.getPhoneNumber();
    phoneNumber.value = x[0]['value'];
    print("getPhoneNumber : ${phoneNumber.value}");
  }

  void logOut() {
    removeToken();
    Get.offAll(() => Login());
  }
}
