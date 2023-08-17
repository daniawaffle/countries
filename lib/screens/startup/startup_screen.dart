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
  StartupBloc startupBloc = StartupBloc();

  @override
  void initState() {
    startupBloc.getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    startupBloc.getCountries();
    return Scaffold(
      backgroundColor: secendaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
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
                    label: AppLocalizations.of(context)!.englishText,
                    startupBloc: startupBloc,
                    localLanguage: enLocale,
                  ),
                  LanguageButton(
                    label: AppLocalizations.of(context)!.arabicText,
                    startupBloc: startupBloc,
                    localLanguage: arLocale,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<Object>(
                stream: startupBloc.countriesStreamController.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: startupBloc.countries.length,
                    itemBuilder: (context, index) {
                      return ListTileWidget(
                        pushNextScreen: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                    countries: startupBloc.countries,
                                    country: startupBloc.countries[index]),
                              ));
                        },
                        country: startupBloc.countries[index],
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
