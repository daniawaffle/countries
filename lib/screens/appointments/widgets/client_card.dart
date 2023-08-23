import 'package:countries_app/constants.dart';
import 'package:countries_app/models/apointments_model.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  final Appoint appoint;
  // final Map<String, dynamic> appointmentJson = {
  //   "id": 12,
  //   "date_from": "2023-02-15T15:00:00",
  //   "date_to": "2023-02-15T15:30:00",
  //   "client_id": 1,
  //   "mentor_id": 6,
  //   "appointment_type": 1,
  //   "price_before_discount": 12,
  //   "price_after_discount": 12,
  //   "state": 1,
  //   "note_from_client": null,
  //   "note_from_mentor": null,
  //   "profile_img": "",
  //   "suffixe_name": "Mrs.",
  //   "first_name": "abed alrahman 6",
  //   "last_name": "al haj hussain",
  //   "category_id": 2,
  //   "categoryName": "طب اطفال"
  // };

  ClientCard({super.key, required this.appoint});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Card(
          color: secendaryColor,
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: primaryColor,
            ),
          ),
          // margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 60,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Card(
                          elevation: 0,
                          color: secendaryColor,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: (appoint.profileImg == null ||
                                  appoint.profileImg == "")
                              ? const CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage("assets/picture-profile.jpeg"))
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      '$mentorImageUrl${appoint.profileImg}')),
                        ),
                        Align(
                          alignment: Alignment
                              .bottomLeft, // Adjust the right position as needed
                          child: Container(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: CircleAvatar(
                              radius: 9.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage("assets/jordan.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "${appoint.firstName} ${appoint.lastName}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.visible,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text("Gender: Prefer Not To Say"),
                        const Text("Day of birth: 5/5/2005")
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
