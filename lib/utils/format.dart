String formattedMinSec(Duration duration) {
  final minString = duration.inMinutes.toString();
  final sec = duration.inSeconds % 60;
  final secString = sec < 10 ? '0${sec.toString()}' : sec.toString();
  return '$minString:$secString';
}
