class ApiResponse<T>{

  final int? statusCode;
  final T? body;
  final bool? success;

  ApiResponse({this.statusCode, this.body, this.success});

  bool get failure => !(success ?? false);

}