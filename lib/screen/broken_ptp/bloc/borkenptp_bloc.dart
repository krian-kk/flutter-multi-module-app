import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/utils/base_equatable.dart';

part 'borkenptp_event.dart';
part 'borkenptp_state.dart';

class BrokenptpBloc extends Bloc<BrokenptpEvent, BrokenptpState> {
  BrokenptpBloc() : super(BrokenptpInitial());
List<CaseListModel> caseList = [];
  @override
  Stream<BrokenptpState> mapEventToState(BrokenptpEvent event) async* {
     if (event is BrokenptpInitialEvent) {
      yield BrokenptpLoadingState();
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
      yield BrokenptpLoadedState();
     }
  }
}
