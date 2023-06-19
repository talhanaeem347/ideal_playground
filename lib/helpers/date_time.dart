
String dateToTime(DateTime time) {
  return '${time.hour % 12}:${time.minute} ${time.hour / 12 > 0 ?  "PM" : "AM" } ';
}