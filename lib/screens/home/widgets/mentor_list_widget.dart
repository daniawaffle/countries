import 'package:countries_app/models/mentor_model.dart';
import 'package:flutter/material.dart';

import 'mentor_card_widget.dart';

class MentorListWidget extends StatefulWidget {
  final List<Mentor>? mentorsList;
  const MentorListWidget({super.key, this.mentorsList});

  @override
  State<MentorListWidget> createState() => _MentorListWidgetState();
}

class _MentorListWidgetState extends State<MentorListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.mentorsList == null ? 0 : widget.mentorsList!.length,
        itemBuilder: (BuildContext context, int index) {
          return MentorCard(mentor: widget.mentorsList![index]);
        });
  }
}
