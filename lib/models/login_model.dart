class LoginApiModel {
  LoginModel? loginModel;
  String? message;

  LoginApiModel({this.loginModel, this.message});

  LoginApiModel.fromJson(Map<String, dynamic> json) {
    loginModel =
        json['data'] != null ? LoginModel.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (loginModel != null) {
      data['data'] = loginModel!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class LoginModel {
  int? id;
  String? apiKey;
  bool? blocked;
  String? firstName;
  String? lastName;
  String? lastOtp;

  LoginModel(
      {this.id,
      this.apiKey,
      this.blocked,
      this.firstName,
      this.lastName,
      this.lastOtp});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    apiKey = json['api_key'];
    blocked = json['blocked'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    lastOtp = json['last_otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['api_key'] = apiKey;
    data['blocked'] = blocked;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['last_otp'] = lastOtp;
    return data;
  }
}
