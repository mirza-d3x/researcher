import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:researcher/rz/Pagination/Api/Model/pagination_model.dart';
import 'package:researcher/rz/Pagination/Api/api_functions.dart';
import 'package:researcher/rz/Pagination/Bloc/bloc/pagination_bloc_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Api/Model/TopUpLoginModelClass.dart';

class PaginationView extends StatefulWidget {
  const PaginationView({super.key});

  @override
  State<PaginationView> createState() => _PaginationViewState();
}

class _PaginationViewState extends State<PaginationView> {
  Future<String> getApiToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    TopUpLoginModelClass topUpLoginModelClass = await ApiS().getToken();
    BlocProvider.of<PaginationBloc>(context).add(GetDataEvent());
    prefs.setString('token', topUpLoginModelClass.data!.access!);
    return topUpLoginModelClass.success.toString();
  }

  num code = 0;

  @override
  void initState() {
    getApiToken();
    super.initState();
  }

  int pageNo = 1;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late SalesPageResponse salesPageResponse;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<PaginationBloc, PaginationState>(
            builder: (context, state) {
              if (state is DataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is DataLoadError) {
                return const Center(
                  child: Text("Error"),
                );
              }
              if (state is DataLoaded) {
                salesPageResponse =
                    BlocProvider.of<PaginationBloc>(context).salesPageResponse;
                return Column(
                  children: [
                    SizedBox(
                      height: 500,
                    ),
                    Expanded(
                      child: SmartRefresher(
                        enablePullDown: false,
                        enablePullUp: true,
                        onLoading: () {
                          print("sfjkjs");
                          setState(() {
                            pageNo = pageNo++;
                          });
                          BlocProvider.of<PaginationBloc>(context).add(
                            LoadPageEvent(
                                pageNo: pageNo,
                                itemPerPage: salesPageResponse.data.length + 5),
                          );
                        },
                        controller: _refreshController,
                        child: ListView.builder(
                          itemCount: salesPageResponse.data.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            color: index % 2 == 0 ? Colors.grey : Colors.white,
                            height: 50,
                            child: Row(
                              children: [
                                Text(
                                    salesPageResponse.data[index].customerName),
                                Text(
                                    salesPageResponse.data[index].deliveryTime),
                                Text(salesPageResponse.data[index].status),
                                Text(salesPageResponse.data[index].grandTotal),
                                Text(salesPageResponse.data[index].phone
                                    .toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
