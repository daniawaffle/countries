class MentorsModel {
  List<Mentor>? mentors;
  String? message;

  MentorsModel({this.mentors, this.message});

  MentorsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      mentors = <Mentor>[];
      json['data'].forEach((v) {
        mentors!.add(Mentor.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mentors != null) {
      data['data'] = mentors!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Mentor {
  int? id;
  String? categoryName;
  String? suffixeName;
  String? firstName;
  String? lastName;
  double? rate;
  double? hourRate;
  String? profileImg;
  List<String>? languages;
  String? countryName;
  String? countryFlag;
  int? numberOfReviewr;

  Mentor(
      {this.id,
      this.categoryName,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.rate,
      this.hourRate,
      this.profileImg,
      this.languages,
      this.countryName,
      this.countryFlag,
      this.numberOfReviewr});

  Mentor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    rate = json['rate'];
    hourRate = json['hour_rate'];
    profileImg = json['profile_img'];
    languages = json['languages'].cast<String>();
    countryName = json['country_name'];
    countryFlag = json['country_flag'];
    numberOfReviewr = json['number_of_reviewr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['suffixe_name'] = suffixeName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['rate'] = rate;
    data['hour_rate'] = hourRate;
    data['profile_img'] = profileImg;
    data['languages'] = languages;
    data['country_name'] = countryName;
    data['country_flag'] = countryFlag;
    data['number_of_reviewr'] = numberOfReviewr;
    return data;
  }
}
