import 'package:flutter/material.dart';

enum AppointmentStatus {
  active(1, "Active", Colors.green),
  mentorCancel(2, "Mentor Cancel", Colors.red),
  clientCancel(3, "Client Cancel", Colors.red),
  clientMiss(4, "Client Miss", Colors.red),
  mentorMiss(5, "Mentor Miss", Colors.red),
  completed(6, "Completed", Colors.green);

  const AppointmentStatus(this.status, this.name, this.textColor);
  final int status;
  final String name;
  final Color textColor;
}

class AppointmentStatusConverter {
  static int getStatusNumber(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.active:
        return 1;
      case AppointmentStatus.mentorCancel:
        return 2;
      case AppointmentStatus.clientCancel:
        return 3;
      case AppointmentStatus.clientMiss:
        return 4;
      case AppointmentStatus.mentorMiss:
        return 5;
      case AppointmentStatus.completed:
        return 6;
      default:
        throw Exception("Invalid status: $status");
    }
  }

  static AppointmentStatus getStatusFromNumber(int number) {
    switch (number) {
      case 1:
        return AppointmentStatus.active;
      case 2:
        return AppointmentStatus.mentorCancel;
      case 3:
        return AppointmentStatus.clientCancel;
      case 4:
        return AppointmentStatus.clientMiss;
      case 5:
        return AppointmentStatus.mentorMiss;
      case 6:
        return AppointmentStatus.completed;
      default:
        throw Exception("Invalid status number: $number");
    }
  }
}
