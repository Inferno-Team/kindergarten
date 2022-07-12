import 'dart:async';

import 'package:get/get.dart';
import 'package:kindergarten/core/services/data_service.dart';
import 'package:kindergarten/models/location_response.dart';
import 'package:kindergarten/utils/cache_manager.dart';

class MyMapController extends GetxController with CacheManager {
  var id = 0;
  @override
  void onInit() { 
    // TODO: implement onInit
    super.onInit();
    // Timer timer =
    //     Timer.periodic(Duration(minutes: 1), (Timer t) => getLocation(id));
  }

  final _service = DataService();
  final _locationResponse = LocationResponse.empty().obs;
  LocationResponse get location => _locationResponse.value;
  getLocation(int id) async {
    _locationResponse.value =
        await _service.getBusLocation(getToken() ?? "", id);
    // print(_locationResponse.value.location);
  }
}
