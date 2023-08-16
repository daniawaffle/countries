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
        elevation: 0, // Set the card elevation
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 12.0),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 1.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                child: Image.network(
                  imageBaseUrl + country.flagImage!,
                  width: 50,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15), // Add some spacing
              Expanded(
                child: Text(
                  country.name!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Icon(
                Localizations.localeOf(context) == const Locale(enLocale)
                    ? Icons.keyboard_arrow_right
                    : Icons.keyboard_arrow_left,
                color: Colors.black,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
