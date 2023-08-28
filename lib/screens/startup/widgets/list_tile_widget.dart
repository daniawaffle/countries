import 'package:countries_app/constants.dart';
import 'package:countries_app/models/country_model.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final Country country;
  final Function onPress;
  const ListTileWidget({super.key, required this.country, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
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
                    AppConstants.imageBaseUrl + country.flagImage!,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  country.name!,
                  style: TextStyle(
                    fontSize: 17,
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Localizations.localeOf(context) == const Locale(AppConstants.enLocale)
                    ? Icons.keyboard_arrow_right
                    : Icons.keyboard_arrow_left,
                color: AppConstants.primaryColor,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
