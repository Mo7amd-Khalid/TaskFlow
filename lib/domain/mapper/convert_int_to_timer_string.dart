String convertIntToTimerString(int milliSecond)
{
  Duration duration = Duration(milliseconds: milliSecond);
  return "${duration.inHours}:${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60)}";
}