import 'package:flutter/material.dart';

import '../../constants.dart';
import 'equiti_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    bloc.getCategories();
    print(bloc.categories);
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
            child: ListView.builder(
              itemCount: bloc.categories.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 15,
                      backgroundColor: secendaryColor,
                      backgroundImage: NetworkImage(
                        categoryImageBaseUrl + bloc.categories[index].icon!,
                      ),
                    ),
                    title: Text(bloc.categories[index].name!),
                    onTap: () {
                      // Handle item tap
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}