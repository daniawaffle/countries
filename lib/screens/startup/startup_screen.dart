import 'package:countries_app/locater.dart';
import 'package:countries_app/screens/login/login_screen.dart';
import 'package:countries_app/screens/startup/startup_bloc.dart';
import 'package:countries_app/screens/startup/widgets/list_tile_widget.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        appBar: AppBar(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: startupBloc.language == "English"
                              ? Colors.blue
                              : Colors.white,
                        ),
                        onPressed: () async {
                          startupBloc.language = "English";

                          await locator<HiveService>().setValue<String>(
                              boxName: languageHiveBox,
                              key: languageHiveKey,
                              value: startupBloc.language!);
                          if (mounted) MainApp.of(context)?.rebuild();
                          setState(() {});
                          fun();
                        },
                        child: Text(
                          // 'english-text'.i18n(),
                          AppLocalizations.of(context)!.englishText,
                          style: TextStyle(
                              color: startupBloc.language == "English"
                                  ? Colors.white
                                  : Colors.blue),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: startupBloc.language == "Arabic"
                              ? Colors.blue
                              : Colors.white,
                        ),
                        onPressed: () async {
                          startupBloc.language = "Arabic";

                          await locator<HiveService>().setValue<String>(
                              boxName: languageHiveBox,
                              key: languageHiveKey,
                              value: startupBloc.language!);

                          if (mounted) MainApp.of(context)?.rebuild();
                          setState(() {});
                          fun();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.arabicText,
                          style: TextStyle(
                              color: startupBloc.language == "Arabic"
                                  ? Colors.white
                                  : Colors.blue),
                        ),
                      ),
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
                            Navigator.push(
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
        ));
  }

  void fun() {
    setState(() {});
  }
}
