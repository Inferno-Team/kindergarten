import 'package:get/get.dart';
import 'package:kindergarten/core/services/data_service.dart';
import 'package:kindergarten/models/message_response.dart';
import 'package:kindergarten/utils/cache_manager.dart';

class MessageViewModel extends GetxController with CacheManager {
  final _dataSource = DataService();
 
}
