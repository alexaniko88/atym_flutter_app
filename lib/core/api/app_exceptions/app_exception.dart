enum ExceptionType {
  offline,
  fetchData,
  unauthorised,
}

class AppException {
  final ExceptionType? type;
  final String? message;

  const AppException({this.type, this.message});

  @override
  String toString() =>
      "Exception of type: ${type.toString()}\nwith message: $message";
}
