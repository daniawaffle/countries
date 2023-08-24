enum AppointmentType {
  schudule(1, "Schudule"),
  instant(2, "Instant");

  const AppointmentType(this.type, this.name);
  final int type;
  final String name;
}

class AppointmentTypeConverter {
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
