import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  Future<bool> saveToken(String? token, int? id, bool isRemamberMe) async {
    final box = GetStorage();
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    await box.write(CacheManagerKey.USER_ID.toString(), id);
    await box.write(CacheManagerKey.RemamberMe.toString(), isRemamberMe);
    return true;
  }

  bool? isRemamberMe() {
    final box = GetStorage();
    return box.read(CacheManagerKey.RemamberMe.toString());
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  String? getUserId() {
    final box = GetStorage();
    return box.read(CacheManagerKey.USER_ID.toString()).toString();
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheManagerKey.TOKEN.toString());
    await box.remove(CacheManagerKey.USER_ID.toString());
  }
}

enum CacheManagerKey { TOKEN, USER_ID, RemamberMe }
