import 'package:flutter_boilerplate/core/base/model/ErrorResp.dart';

enum StatusType { Success, Fail }

class BaseResponse {
  String status;
  ErrorResp error;

  BaseResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = json['status'];
    }

    if (json['error'] != null) {
      error = ErrorResp.fromJson(json['error']);
    }
  }


  isSuccess() {
    if (status != null && status == "Success") {
      return true;
    }
    return false;
  }
}
