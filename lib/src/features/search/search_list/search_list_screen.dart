import 'package:design_system/widgets/custom_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/models/searching_data_model.dart';
import 'package:origa/src/features/search/search_list/bloc/search_list_bloc.dart';
import 'package:origa/utils/skeleton.dart';
import 'package:origa/widgets/no_case_available.dart';

import '../../../../models/priority_case_list.dart';

class SearchListScreen extends StatefulWidget {
  final SearchingDataModel searchData;

  const SearchListScreen({super.key, required this.searchData});

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  bool isCaseDetailLoading = false;
  List<Result> resultList = [];

  // late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = ScrollController()..addListener(_loadMore);

    BlocProvider.of<SearchListBloc>(context)
        .add(SearchListInitialEvent(searchData: widget.searchData));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchListBloc, SearchListState>(
      bloc: BlocProvider.of<SearchListBloc>(context),
      listener: (context, state) {},
      child: BlocBuilder<SearchListBloc, SearchListState>(
        builder: (BuildContext context, state) {
          if (state is CaseListViewLoadingState) {
            return const SkeletonLoading();
          }
          return Scaffold(
              body: state is SearchSuccessReturnDataState
                  ? resultList.isEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 50, right: 20, left: 20),
                              child: NoCaseAvailble.buildNoCaseAvailable(),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          //FINISH IT!!
                          child: CustomCardList.buildListView(
                            BlocProvider.of<SearchListBloc>(context),
                            resultData: resultList,
                            // listViewController: _controller,
                          ))
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 50, right: 20, left: 20),
                          child: NoCaseAvailble.buildNoCaseAvailable(),
                        ),
                      ],
                    ));
        },
      ),
    );
  }
}
