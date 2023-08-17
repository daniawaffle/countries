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
    super.initState();
  }

  EquitiAcademyBloc bloc = EquitiAcademyBloc();
  int _selectedIndex = 0;

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
            flex: 4,
            child: StreamBuilder(
                stream: bloc.categoriesStreamController.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: bloc.categories.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10),
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: secendaryColor,
                            backgroundImage: NetworkImage(
                              categoryImageBaseUrl +
                                  bloc.categories[index].icon!,
                            ),
                          ),
                          title: Text(
                            bloc.categories[index].name!,
                            style: const TextStyle(fontSize: 14),
                          ),
                          onTap: () async {
                            await bloc.getMentors(bloc.categories[index].id!);
                          },
                        ),
                      );
                    },
                  );
                }),
          ),
          Expanded(
              flex: 5,
              child: StreamBuilder<List<Mentor>>(
                  stream: bloc.mentorsStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return MentorListWidget(
                        mentorsList: snapshot.data,
                      );
                    } else {
                      return const CircularProgressIndicator();
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
