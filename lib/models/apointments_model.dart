class AppointmentsModel {
  List<Appoint>? data;
  String? message;

  AppointmentsModel({this.data, this.message});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Appoint>[];
      json['data'].forEach((v) {
        data!.add(Appoint.fromJson(v));
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

class Appoint {
  int? id;
  DateTime? dateFrom;
  DateTime? dateTo;
  int? clientId;
  int? mentorId;
  int? appointmentType;
  double? priceBeforeDiscount;
  double? priceAfterDiscount;
  int? state;
  String? noteFromClient;
  String? noteFromMentor;
  String? profileImg;
  String? suffixeName;
  String? firstName;
  String? lastName;
  int? categoryId;
  String? categoryName;

  Appoint(
      {this.id,
      this.dateFrom,
      this.dateTo,
      this.clientId,
      this.mentorId,
      this.appointmentType,
      this.priceBeforeDiscount,
      this.priceAfterDiscount,
      this.state,
      this.noteFromClient,
      this.noteFromMentor,
      this.profileImg,
      this.suffixeName,
      this.firstName,
      this.lastName,
      this.categoryId,
      this.categoryName});

  Appoint.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateFrom = DateTime.parse(json['date_from']);
    dateTo = DateTime.parse(json['date_to']);
    clientId = json['client_id'];
    mentorId = json['mentor_id'];
    appointmentType = json['appointment_type'];
    priceBeforeDiscount = json['price_before_discount'].toDouble();
    priceAfterDiscount = json['price_after_discount'].toDouble();
    state = json['state'];
    noteFromClient = json['note_from_client'];
    noteFromMentor = json['note_from_mentor'];
    profileImg = json['profile_img'];
    suffixeName = json['suffixe_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    categoryId = json['category_id'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date_from'] = dateFrom;
    data['date_to'] = dateTo;
    data['client_id'] = clientId;
    data['mentor_id'] = mentorId;
    data['appointment_type'] = appointmentType;
    data['price_before_discount'] = priceBeforeDiscount;
    data['price_after_discount'] = priceAfterDiscount;
    data['state'] = state;
    data['note_from_client'] = noteFromClient;
    data['note_from_mentor'] = noteFromMentor;
    data['profile_img'] = profileImg;
    data['suffixe_name'] = suffixeName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['category_id'] = categoryId;
    data['categoryName'] = categoryName;
    return data;
  }
}
