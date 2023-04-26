import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:researcher/rz/Pagination/Api/Model/pagination_model.dart';
import 'package:researcher/rz/Pagination/Api/api_functions.dart';

part 'pagination_bloc_event.dart';
part 'pagination_bloc_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  ApiS apiS;
  late SalesPageResponse salesPageResponse;
  PaginationBloc(this.apiS) : super(PaginationBlocInitial()) {
    on<GetDataEvent>((event, emit) async {
      emit(DataLoading());
      try {
        salesPageResponse = await apiS.getSalesData(pageNo: 1, itemsPerPage: 5);
        emit(DataLoaded());
      } catch (e) {
        log(e.toString());
        emit(DataLoadError());
      }
    });

    on<LoadPageEvent>((event, emit) async {
      try {
        salesPageResponse = await apiS.getSalesData(
            pageNo: event.pageNo, itemsPerPage: event.itemPerPage);
        emit(DataLoaded());
      } catch (e) {
        log(e.toString());
        emit(DataLoadError());
      }
    });
  }
}
