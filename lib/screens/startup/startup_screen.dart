import 'package:countries_app/locater.dart';
import 'package:countries_app/screens/startup/startup_bloc.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../services/api.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  StartupBloc startupBloc = StartupBloc();

  @override
  void initState() {
    print(startupBloc.countries);
    startupBloc.getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Country API'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                        print(startupBloc.language);
                        await locator<ApiService>().getCountriesData;
                        if (mounted) MainApp.of(context)?.rebuild();
                        setState(() {});
                        fun();
                      },
                      child: Text(
                        // 'english-text'.i18n(),
                        'Abed-text'.i18n(),
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
                        print(startupBloc.language);

                        if (mounted) MainApp.of(context)?.rebuild();
                        setState(() {});
                        fun();
                      },
                      child: Text(
                        'arabic-text'.i18n(),
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
            Expanded(
              child: ListView.builder(
                itemCount: startupBloc.countries.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle item click
                      print('Clicked: ${startupBloc.countries[index].name}');
                    },
                    child: ListTile(
                      title: Text(startupBloc.countries[index].name!),
                      // trailing: Text(startupBloc.countries[index].flag),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  void fun() {
    setState(() {});
  }
}
