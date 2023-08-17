import 'package:countries_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MentorCard extends StatelessWidget {
  const MentorCard({super.key});

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
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/picture-profile.jpeg")),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Mr. Saleh Yousef',
                                overflow: TextOverflow.visible,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'category name',
                                style: TextStyle(fontSize: 15),
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
                      Text("Languages : "),
                      Wrap(
                        children:
                            entries.map((entry) => Text("testt ")).toList(),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 8, 20, 8),
                child: Text("Hour Rate :"),
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
                                "https://www.helpera.app/static/countries/jordan.png"),
                          ),
                          Text(
                            'Jordan',
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
                          rating: 2.75,
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
