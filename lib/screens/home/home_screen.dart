import 'package:countries_app/models/mentor_model.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

import 'equiti_bloc.dart';
import 'widgets/mentor_list_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc bloc = HomeBloc();
  @override
  void initState() {
    bloc.getCategories();
    bloc.getMentors(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appBarText),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: StreamBuilder(
                stream: bloc.categoriesStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        bool isSelected = index == bloc.selectedItemIndex;

                        return Card(
                            color: isSelected
                                ? AppConstants.selectedItemColor
                                : Colors.white,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  bloc.selectedItemIndex = index;
                                });
                                await bloc
                                    .getMentors(snapshot.data![index].id!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          AppConstants.secendaryColor,
                                      backgroundImage: NetworkImage(
                                        AppConstants.categoryImageBaseUrl +
                                            snapshot.data![index].icon!,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapshot.data![index].name!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    );
                  }

                  return const CircularProgressIndicator();
                }),
          ),
          Expanded(
              flex: 6,
              child: StreamBuilder<List<Mentor>>(
                  stream: bloc.mentorsStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return MentorListWidget(
                        mentorsList: snapshot.data,
                      );
                    } else {
                      return Center(
                          child:
                              Text(AppLocalizations.of(context)!.noDataText));
                    }
                  })),
        ],
      ),
    );
  }
}
