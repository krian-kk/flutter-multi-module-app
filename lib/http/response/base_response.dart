abstract class BaseResponse {
  int status;
  String message;
  String error;

  BaseResponse(this.status, this.message, this.error);
}
