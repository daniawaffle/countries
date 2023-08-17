import 'package:countries_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/mentor_model.dart';

class MentorCard extends StatelessWidget {
  MentorCard({super.key});
  Map<String, dynamic> mentorData = {
    "id": 1,
    "category_name": "Psychology",
    "suffixe_name": "Sr.",
    "first_name": "abed alrahman 1",
    "last_name": "al haj hussain",
    "rate": 0.0,
    "hour_rate": 20.5,
    "profile_img": "1.png",
    "languages": ["English", "العربية"],
    "country_name": "Qatar",
    "country_flag": "qatar.png",
    "number_of_reviewr": 0,
  };

  // final Mentor mentor;
  // const MentorCard({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    Mentor mentor = Mentor(
      id: mentorData["id"],
      categoryName: mentorData["category_name"],
      suffixeName: mentorData["suffixe_name"],
      firstName: mentorData["first_name"],
      lastName: mentorData["last_name"],
      rate: mentorData["rate"],
      hourRate: mentorData["hour_rate"],
      profileImg: mentorData["profile_img"],
      languages: List<String>.from(mentorData["languages"]),
      countryName: mentorData["country_name"],
      countryFlag: mentorData["country_flag"],
      numberOfReviewr: mentorData["number_of_reviewr"],
    );
    final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F'];
    return Center(
      child: SafeArea(
        child: Card(
          color: secendaryColor,
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: primaryColor,
            ),
            // borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 0,
                      color: secendaryColor,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child:
                          (mentor.profileImg == null || mentor.profileImg == "")
                              ? const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage("assets/picture-profile.jpeg"))
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      '$mentorImage${mentor.profileImg}')),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${mentor.suffixeName} ${mentor.firstName}',
                                overflow: TextOverflow.visible,
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                mentor.categoryName ?? "",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 8, 20, 8),
                  child: Wrap(
                    children: [
                      const Text("Languages : "),
                      Wrap(
                        children: entries
                            .map((entry) => const Text("testt "))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 8, 20, 8),
                child: Text("Hour Rate : ${mentor.hourRate}"),
              ),
              Card(
                color: secendaryColor,
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: primaryColor,
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image(
                            width: 60,
                            height: 40,
                            image: NetworkImage(
                                '$imageBaseUrl${mentor.countryFlag}'),
                          ),
                          Text(
                            '${mentor.categoryName}',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      VerticalDivider(
                        color: primaryColor,
                        thickness: 1,
                      ),
                      Flexible(
                        child: RatingBarIndicator(
                          rating: mentor.rate!,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 30.0,
                          direction: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
