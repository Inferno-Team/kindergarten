import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/student_view_model.dart';
import 'package:kindergarten/models/student.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class CameraPage extends GetWidget<StudentViewModel> {
  final Student student;
  CameraPage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    controller.getCameraIP(student.id);
    return Container(
      width: 400,
      margin: const EdgeInsets.only(top: 24),
      height: size.height - 24,
      child: VlcPlayer(
        controller: controller.liveController,
        aspectRatio: 16 / 9,
        placeholder: SizedBox(
          height: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
