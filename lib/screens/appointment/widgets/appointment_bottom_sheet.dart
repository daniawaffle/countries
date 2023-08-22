import 'package:flutter/material.dart';

import 'client_card.dart';

class AppointmentBottomSheet extends StatelessWidget {
  const AppointmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return bottomSheetMethod(context);
  }

  bottomSheetMethod(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Text("Meeting\nwith"),
                  Icon(Icons.close)
                ],
              ),
              // ClientCard(),
            ],
          );
        });
  }
}
