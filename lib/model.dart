class CountriesModel {
  List<Data>? data;
  String? message;

  CountriesModel({this.data, this.message});

  CountriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? flagImage;
  String? name;
  String? currency;
  String? dialCode;
  int? minLength;
  int? maxLength;

  Data(
      {this.id,
      this.flagImage,
      this.name,
      this.currency,
      this.dialCode,
      this.minLength,
      this.maxLength});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flagImage = json['flag_image'];
    name = json['name'];
    currency = json['currency'];
    dialCode = json['dialCode'];
    minLength = json['minLength'];
    maxLength = json['maxLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['flag_image'] = flagImage;
    data['name'] = name;
    data['currency'] = currency;
    data['dialCode'] = dialCode;
    data['minLength'] = minLength;
    data['maxLength'] = maxLength;
    return data;
  }
}
