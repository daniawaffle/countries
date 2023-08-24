enum AppointmentType {
  schudule(1, "Schudule"),
  instant(2, "Instant");

  const AppointmentType(this.type, this.name);
  final int type;
  final String name;
}

class AppointmentTypeConverter {
  static int getStatusNumber(AppointmentType type) {
    switch (type) {
      case AppointmentType.schudule:
        return 1;
      case AppointmentType.instant:
        return 2;
      default:
        throw Exception("Invalid Type: $type");
    }
  }

  static AppointmentType getTypeFromNumber(int number) {
    switch (number) {
      case 1:
        return AppointmentType.schudule;
      case 2:
        return AppointmentType.instant;
      default:
        throw Exception("Invalid Type number: $number");
    }
  }
}
