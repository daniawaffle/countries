import 'package:countries_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/mentor_model.dart';

class MentorCard extends StatelessWidget {
  final Mentor mentor;
  const MentorCard({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Card(
          color: AppConstants.secendaryColor,
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppConstants.primaryColor,
            ),
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
                      color: AppConstants.secendaryColor,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: (mentor.profileImg == null ||
                              mentor.profileImg == "")
                          ? const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage(AppConstants.defaultUserImage))
                          : CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  '${AppConstants.mentorImageUrl}${mentor.profileImg}')),
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
                    direction: Axis.horizontal,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.languageText} : ",
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        children: mentor.languages!
                            .map((entry) => Card(
                                color: AppConstants.primaryColor,
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
                child: Text(
                    "${AppLocalizations.of(context)!.hourRateText} : ${mentor.hourRate}"),
              ),
              Card(
                color: AppConstants.secendaryColor,
                margin: EdgeInsets.zero,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: AppConstants.primaryColor,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              width: 50,
                              height: 30,
                              image: NetworkImage(
                                  '${AppConstants.imageBaseUrl}${mentor.countryFlag}'),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              child: Text(
                                '${mentor.countryName}',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: AppConstants.primaryColor,
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
                        Text('${mentor.numberOfReviewr}')
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
