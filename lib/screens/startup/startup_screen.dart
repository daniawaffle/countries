import 'package:countries_app/models/country_model.dart';
import 'package:countries_app/screens/login/login_screen.dart';
import 'package:countries_app/screens/startup/startup_bloc.dart';
import 'package:countries_app/screens/startup/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'widgets/language_button.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  StartupBloc bloc = StartupBloc();

  @override
  void initState() {
    bloc.getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.secendaryColor,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryColor,
        title: Text(AppLocalizations.of(context)!.setupText),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LanguageButton(
                    currentLanguage: bloc.getLan(),
                    label: AppLocalizations.of(context)!.englishText,
                    localLanguage: AppConstants.enLocale,
                    saveLanguage: () {
                      bloc.saveLanguageToHive(context, AppConstants.enLocale);
                    },
                  ),
                  LanguageButton(
                    currentLanguage: bloc.getLan(),
                    label: AppLocalizations.of(context)!.arabicText,
                    localLanguage: AppConstants.arLocale,
                    saveLanguage: () {
                      bloc.saveLanguageToHive(context, AppConstants.arLocale);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Country>>(
                stream: bloc.countriesStreamController.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount:
                        (snapshot.data == null ? 0 : snapshot.data!.length),
                    itemBuilder: (context, index) {
                      return ListTileWidget(
                        country: snapshot.data![index],
                        onPress: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                    listOfCountries: snapshot.data!,
                                    selectedCountry: snapshot.data![index]),
                              ));
                        },
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
