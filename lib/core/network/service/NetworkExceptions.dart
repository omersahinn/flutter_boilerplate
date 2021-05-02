
class NetworkExceptions<T> implements Exception {
  final _message;
  final _prefix;
  final T tag;

  NetworkExceptions([this._message, this._prefix,this.tag]);

  String toString() {
    return "$_message";
  }
}

class FetchDataException extends NetworkExceptions {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class NoConnectionError extends NetworkExceptions {
  NoConnectionError ([message]) : super(message, "No Internet: ");
}

class NotFound extends NetworkExceptions {
  NotFound([message]) : super(message, "Not Found: ");
}

class UnauthorisedException extends NetworkExceptions {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends NetworkExceptions {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
