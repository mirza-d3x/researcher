part of 'pagination_bloc_bloc.dart';

@immutable
abstract class PaginationEvent {}

class GetDataEvent extends PaginationEvent {}

class LoadPageEvent extends PaginationEvent {
  final int pageNo;
  final int itemPerPage;

  LoadPageEvent({required this.pageNo, required this.itemPerPage});
}
