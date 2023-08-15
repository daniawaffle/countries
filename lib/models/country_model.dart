class CountriesMdoel {
  List<Country>? data;
  String? message;

  CountriesMdoel({this.data, this.message});

  CountriesMdoel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Country>[];
      json['data'].forEach((v) {
        data!.add(Country.fromJson(v));
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

class Country {
  int? id;
  String? flagImage;
  String? name;
  String? currency;
  String? dialCode;
  int? minLength;
  int? maxLength;

  Country(
      {this.id,
      this.flagImage,
      this.name,
      this.currency,
      this.dialCode,
      this.minLength,
      this.maxLength});

  Country.fromJson(Map<String, dynamic> json) {
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
