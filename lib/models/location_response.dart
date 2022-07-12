import 'dart:ffi';

import 'package:latlong2/latlong.dart' as latlong;

class LocationResponse {
  final bool status;
  final String msg;
  final String errorNumber;
  final latlong.LatLng location;

  LocationResponse(
      {required this.status,
      required this.msg,
      required this.errorNumber,
      required this.location});
  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    var lat = json['gbs'][0]['x'];
    var lng = json['gbs'][0]['y'];
    print(lat.runtimeType);
    return LocationResponse(
        status: json['stauts'] ?? false,
        msg: json['msg'] ?? "",
        errorNumber: json['errNum'] ?? "-1",
        location: latlong.LatLng(double.parse(lat), double.parse(lng)));
  }
  factory LocationResponse.empty() {
    return LocationResponse(
        status: false,
        msg: "",
        errorNumber: "-1",
        location: latlong.LatLng(36.20286682357239, 37.13132498620267));
  }
}
