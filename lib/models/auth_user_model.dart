class AuthUserModel {
  String? title;
  String? message;
  Data? data;

  AuthUserModel({this.title, this.message, this.data});

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    message = json["message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["message"] = message;
    if (data != null) {
      _data["data"] = data?.toJson();
    }
    return _data;
  }
}

class Data {
  String? userToken;
  var id;
  String? name;
  String? mobile;
  String? email;

  Data({this.userToken, this.id, this.name, this.mobile, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    userToken = json["user_token"];
    id = json["id"];
    name = json["name"];
    mobile = json["mobile"];
    email = json["email"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["user_token"] = userToken;
    _data["id"] = id;
    _data["name"] = name;
    _data["mobile"] = mobile;
    _data["email"] = email;
    return _data;
  }
}
