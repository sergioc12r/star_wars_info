import 'package:star_wars_info/src/models/response/api_response.dart';
import 'package:star_wars_info/src/models/response/pagination.dart';

class PaginatedResponse<T, K> extends ApiResponse<List<T>>{

  final Pagination? pagination;
  final K? additionalInfo;

  PaginatedResponse({this.pagination, this.additionalInfo, body}):
        super(
        body:  body,
      );

}