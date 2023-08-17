import 'package:countries_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/mentor_model.dart';

class MentorCard extends StatelessWidget {
  final Mentor mentor;
  const MentorCard({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
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
                        children: mentor.languages!
                            .map((entry) => Card(
                                color: primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    entry,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )))
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image(
                              width: 50,
                              height: 30,
                              image: NetworkImage(
                                  '$imageBaseUrl${mentor.countryFlag}'),
                            ),
                            Text(
                              '${mentor.countryName}',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: primaryColor,
                          thickness: 1,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: RatingBarIndicator(
                            rating: mentor.rate!,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 18.0,
                            direction: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),
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
