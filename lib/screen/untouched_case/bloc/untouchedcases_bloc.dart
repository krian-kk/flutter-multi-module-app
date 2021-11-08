import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/utils/base_equatable.dart';

part 'untouchedcases_event.dart';
part 'untouchedcases_state.dart';

class UntouchedcasesBloc extends Bloc<UntouchedcasesEvent, UntouchedcasesState> {
  UntouchedcasesBloc() : super(UntouchedcasesInitial());
  List<CaseListModel> caseList = [];
  Stream<UntouchedcasesState> mapEventToState(UntouchedcasesEvent event) async* {
    if (event is UntouchedcasesInitialEvent) {
      yield UntouchedcasesLoadingState();
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
       yield UntouchedcasesLoadedState();

    }
  }
}
