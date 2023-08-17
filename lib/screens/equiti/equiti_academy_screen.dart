import 'package:countries_app/models/mentor_model.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'equiti_bloc.dart';
import 'mentor_list_widget.dart';

class EquitiAcademyScreen extends StatefulWidget {
  const EquitiAcademyScreen({super.key});

  @override
  State<EquitiAcademyScreen> createState() => _EquitiAcademyScreenState();
}

class _EquitiAcademyScreenState extends State<EquitiAcademyScreen> {
  @override
  void initState() {
    bloc.getCategories();
    bloc.getMentors(1);
    super.initState();
  }

  EquitiAcademyBloc bloc = EquitiAcademyBloc();
  int _selectedIndex = 1;
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equiti academy'),
        backgroundColor: primaryColor,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: StreamBuilder(
                stream: bloc.categoriesStreamController.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: bloc.categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected = index == selectedItemIndex;

                      return Card(
                          color: isSelected ? selectedItemColor : Colors.white,
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                selectedItemIndex =
                                    index; // Update the selected index
                              });
                              await bloc.getMentors(bloc.categories[index].id!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: secendaryColor,
                                    backgroundImage: NetworkImage(
                                      categoryImageBaseUrl +
                                          bloc.categories[index].icon!,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    bloc.categories[index].name!,
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
                      return const Center(child: Text("Not data to show"));
                    }
                  })),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        selectedIconTheme: IconThemeData(
          color: primaryColor,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: ''),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }
}
