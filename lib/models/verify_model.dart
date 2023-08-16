class VerifyApiModel {
  Data? verifyModel;
  String? message;

  VerifyApiModel({this.verifyModel, this.message});

  VerifyApiModel.fromJson(Map<String, dynamic> json) {
    verifyModel = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (verifyModel != null) {
      data['data'] = verifyModel!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  String? token;
  String? tokenType;

  Data({this.token, this.tokenType});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['token_type'] = tokenType;
    return data;
  }
}
