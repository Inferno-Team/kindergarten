import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kindergarten/core/view_models/student_view_model.dart';
import 'package:kindergarten/models/student.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class CameraPage extends StatefulWidget {
  final Student student;
  const CameraPage({Key? key, required this.student}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState(studentId: student.id);
}

class _CameraPageState extends State<CameraPage> {
  VlcPlayerController? _liveController;
  final StudentViewModel controller =
      Get.find(tag: "student_view_model_controller");
  final int studentId;
  _CameraPageState({required this.studentId});
  @override
  void initState() {
    controller.getCameraIP(studentId);
    _liveController =
        VlcPlayerController.network('rtsp://192.168.43.198:8080/h264_ulaw.sdp');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            child: SizedBox(
              width: 400,
              height: 300,
              child: VlcPlayer(
                controller: _liveController!,
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
            ),
          ),
        ],
      ),
    );
  }

  void _play() {
    if (_liveController!.isReadyToInitialize!) {
      print("ready to initialize");
      // _liveController!.initialize();
      _liveController!.play();
    } else {
      print("not ready to initialize");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _liveController!.dispose();
  }
}
