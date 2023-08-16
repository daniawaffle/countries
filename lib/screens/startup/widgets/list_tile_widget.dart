import 'package:countries_app/constants.dart';
import 'package:countries_app/models/country_model.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final Country country;
  final Function pushNextScreen;
  const ListTileWidget(
      {super.key, required this.country, required this.pushNextScreen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNextScreen();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
          //set border radius more than 50% of height and width to make circle
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 12.0),
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    imageBaseUrl + country.flagImage!,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  country.name!,
                  style: TextStyle(
                    fontSize: 17,
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Localizations.localeOf(context) == const Locale(enLocale)
                    ? Icons.keyboard_arrow_right
                    : Icons.keyboard_arrow_left,
                color: primaryColor,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
