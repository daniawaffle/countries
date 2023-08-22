class AppointmentDetailBloc {
  String formatDuration(
      {required DateTime dateFrom, required DateTime dateTo}) {
    Duration duration = dateTo.difference(dateFrom);
    if (duration.inMinutes < 60) {
      return '${duration.inMinutes} min';
    } else {
      int hours = duration.inMinutes ~/ 60;
      int minutes = duration.inMinutes % 60;
      String result = (minutes == 0 ? "$hours h" : '$hours h $minutes min');
      return result;
    }
  }
}
