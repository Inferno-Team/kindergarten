


class CameraResponse {
  final bool status;
  final dynamic errorNumber;
  final String msg;
  final String cameraIP;
  CameraResponse(
      {required this.status,
      required this.errorNumber,
      required this.msg,
      required this.cameraIP});

  factory CameraResponse.fromJson(dynamic json) {
    var status = json['status'] ?? false;
    var errorNumber = json['errNum'] ?? "0";
    var msg = json['msg'] ?? "";
    var cameraIP = json['camera'][0]['Camera_IP'] ?? "";
    return CameraResponse(
        status: status, errorNumber: errorNumber, msg: msg, cameraIP: cameraIP);
  }
}
