class UserModel {
  String? token;
  String? email;
  String? username;

  UserModel({this.token, this.email, this.username});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['email'] ?? "eve.holt@reqres.in";
    username = json['username'] ?? "Desktop user";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};  
    data['token'] = token;
    data['email'] = email;
    data['username'] = username;

    return data;
  }
}
