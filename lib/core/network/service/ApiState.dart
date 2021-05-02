import 'package:flutter_boilerplate/core/base/model/BaseResponse.dart';

class ApiState<T> {
  Status status;
  T data;
  String message;
  String apiMessage;
  int apiCode;
  BaseResponse baseResponse;

  ApiState.loading(this.message) : status = Status.LOADING;

  ApiState.completed(this.data) : status = Status.COMPLETED;

  ApiState.error(
    this.message,
  ) : status = Status.ERROR;

  ApiState.errorNoConnection(
    this.message,
  ) : status = Status.NO_CONNECTION;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR, NO_CONNECTION, BAD_REQUEST }
