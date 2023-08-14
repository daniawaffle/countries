import 'package:countries_app/screens/startup/startup_bloc.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  StartupBloc startupBloc = StartupBloc();
  List<Country> countries = [
    Country(name: 'USA', flag: '🇺🇸'),
    Country(name: 'Canada', flag: '🇨🇦'),
    Country(name: 'Australia', flag: '🇦🇺'),
    Country(name: 'France', flag: '🇫🇷'),
    Country(name: 'Germany', flag: '🇩🇪'),
    Country(name: 'Japan', flag: '🇯🇵'),
    Country(name: 'China', flag: '🇨🇳'),
  ];

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
                      onPressed: () {
                        startupBloc.language = "English";

                        setState(() {});
                      },
                      child: Text(
                        "English",
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
                      onPressed: () {
                        startupBloc.language = "Arabic";

                        setState(() {});
                      },
                      child: Text(
                        "Arabic",
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
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle item click
                      print('Clicked: ${countries[index].name}');
                    },
                    child: ListTile(
                      title: Text(
                        startupBloc.language == languagesList[0]
                            ? countries[index].name
                            : getArabicCountryName(countries[index].name),
                      ),
                      trailing: Text(countries[index].flag),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  String getArabicCountryName(String englishName) {
    // You can implement your own translation logic here
    // This is just a placeholder
    if (englishName == 'USA') return 'الولايات المتحدة';
    if (englishName == 'Canada') return 'كندا';
    if (englishName == 'Australia') return 'أستراليا';
    if (englishName == 'France') return 'فرنسا';
    if (englishName == 'Germany') return 'ألمانيا';
    if (englishName == 'Japan') return 'اليابان';
    if (englishName == 'China') return 'الصين';
    return englishName;
  }
}

class Country {
  final String name;
  final String flag;

  Country({required this.name, required this.flag});
}
