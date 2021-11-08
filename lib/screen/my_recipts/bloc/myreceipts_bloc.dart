import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/my_visit/bloc/myvisits_bloc.dart';
import 'package:origa/utils/base_equatable.dart';

part 'myreceipts_event.dart';
part 'myreceipts_state.dart';

class MyreceiptsBloc extends Bloc<MyreceiptsEvent, MyreceiptsState> {
  MyreceiptsBloc() : super(MyreceiptsInitial());

  List<CaseListModel> caseList = [];

  String? selectedFilter;

   List<String> filterOption = [];
  Stream<MyreceiptsState> mapEventToState(MyreceiptsEvent event) async* {

    if (event is MyreceiptsInitialEvent) {
      yield MyreceiptsLoadingState();

      selectedFilter = Languages.of(event.context)!.today;
      filterOption.addAll([
              Languages.of(event.context)!.today,
              Languages.of(event.context)!.weekly,
              Languages.of(event.context)!.monthly,
            ]);
            
      caseList.addAll([
        CaseListModel(
          newlyAdded: true,
          customerName: 'Debashish Patnaik',
          amount: '₹ 3,97,553.67',
          address: '2/345, 6th Main Road Gomathipuram, Madurai - 625032',
          date: 'Today, Thu 18 Oct, 2021',
          loanID: 'TVS / TVSF_BFRT6524869550',
          ),
          CaseListModel(
          newlyAdded: true,
          customerName: 'New User',
          amount: '₹ 5,54,433.67',
          address: '2/345, 6th Main Road, Bangalore - 534544',
          date: 'Thu, Thu 18 Oct, 2021',
          loanID: 'TVS / TVSF_BFRT6524869550',
          ),
          CaseListModel(
          newlyAdded: true,
          customerName: 'Debashish Patnaik',
          amount: '₹ 8,97,553.67',
          address: '2/345, 1th Main Road Guindy, Chenai - 875032',
          date: 'Sat, Thu 18 Oct, 2021',
          loanID: 'TVS / TVSF_BFRT6524869550',
          ),
      ]); 
       yield MyreceiptsLoadedState();

    }
  }
}
