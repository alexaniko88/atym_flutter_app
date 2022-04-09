extension IntExtensions on int {
  bool isBetween({
    required int from,
    required int to,
  }) =>
       this <= from  && this > to;
}
