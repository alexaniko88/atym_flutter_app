enum ExceptionType {
  offline,
  fetchData,
  unauthorised,
  wrongAsset,
}

class AppException {
  final ExceptionType? type;
  final String? message;

  const AppException({this.type, this.message});

  @override
  String toString() =>
      "App Exception: ${type.toString()}\nwith message: $message";
}
