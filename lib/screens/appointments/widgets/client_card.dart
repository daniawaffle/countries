import 'package:countries_app/constants.dart';
import 'package:countries_app/models/apointments_model.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  final Appoint appoint;
  const ClientCard({super.key, required this.appoint});

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
                    height: 70,
                    width: 80,
                    child: Stack(
                      fit: StackFit.loose,

                      // alignment: Alignment.center,
                      children: [
                        Card(
                          elevation: 0,
                          color: secendaryColor,
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
                            padding: const EdgeInsets.only(
                                right: 20.0, left: 20, bottom: 10),
                            child: const CircleAvatar(
                              radius: 9.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage("assets/jordan.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
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
