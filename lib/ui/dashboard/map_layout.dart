import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/home_view_mode.dart';
import 'package:kindergarten/core/view_models/map_view_model.dart';
import 'package:kindergarten/models/student.dart';

class MapLayout extends GetWidget<MyMapController> {
  final Student student;
  MapLayout({Key? key, required this.student}) : super(key: key);
  final HomeViewModel _homeViewModel = Get.find(tag: "HomeViewModel");
  @override
  Widget build(BuildContext context) {
    controller.id = student.id;
    controller.getLocation(student.id);
    return Obx(
      () => WillPopScope(
          onWillPop: () async {
            await _homeViewModel.onBackPressed();
            return true;
          },
          child: FlutterMap(
            options: MapOptions(
              center: controller.location.location,
              zoom: 14,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    point: controller.location.location,
                    width: 32,
                    height: 32,
                    builder: (context) => Icon(
                      Icons.location_on,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: 'OpenStreetMap contributors',
                onSourceTapped: null,
              ),
            ],
          )),
    );
  }
}
