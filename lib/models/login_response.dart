class Parent {
  final int id;
  final String token;
  Parent({required this.id, required this.token});
  factory Parent.fromJson(dynamic json) {
    final int id = json['id'] ?? -1;
    final String token = json['api_token'] ?? "";
    return Parent(token: token, id: id);
  }
  factory Parent.empty() {
    return Parent(id: -2, token: "");
  }
}

class LoginResponse {
  final Parent parent;
  final bool status;
  final String message;
  LoginResponse({required this.parent, this.status = false, this.message = ""});

  factory LoginResponse.fromJson(dynamic json) {
    var parent = Parent.fromJson(json['parent']);
    var _code = json['status'] ?? false;
    var _message = json['message'] ?? "";
    return LoginResponse(parent: parent, status: _code, message: _message);
  }
  factory LoginResponse.empty() {
    return LoginResponse(parent: Parent.empty());
  }
}
