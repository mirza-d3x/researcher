part of 'pagination_bloc_bloc.dart';

@immutable
abstract class PaginationState {}

class PaginationBlocInitial extends PaginationState {}

class DataLoading extends PaginationState {}

class DataLoaded extends PaginationState {}

class DataLoadError extends PaginationState {}
