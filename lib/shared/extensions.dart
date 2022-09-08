extension DateTimeExtension on DateTime {

  String formattedDate(DateTime date) {
    return year.toString();
  }
}

extension intExtention on int{
  String formattedNumber(){
    return '${(this/1000).toStringAsFixed(1)}k';
  }
}
