import 'package:bloc/bloc.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/screen/dashboard/case_list_widget.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/image_resource.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());
  List<DashboardListModel> dashboardList = [];
  List<CaseListModel> caseList = [];
  String? selectedFilter = 'TODAY';

  List<String> filterOption = [
    'TODAY',
    'WEEKLY',
    'MONTHLY',
  ];

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardEvent) {
      yield DashboardLoadingState();

      dashboardList.addAll([
        DashboardListModel(
            title: 'PRIORITY FOLLOW UP',
            image: ImageResource.vectorArrow,
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'),
        DashboardListModel(
            title: 'UNTOUCHED CASES',
            image: ImageResource.vectorArrow,
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'),
        DashboardListModel(
            title: 'BROKEN PTP',
            image: ImageResource.vectorArrow,
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'),
        DashboardListModel(
            title: 'MY RECEIPTS',
            image: ImageResource.vectorArrow,
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'),
        DashboardListModel(
            title: 'MY VISITS',
            image: ImageResource.vectorArrow,
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'),
        DashboardListModel(
            title: 'MY DEPOSISTS',
            image: '',
            count: '',
            countNum: '',
            amount: '',
            amountRs: ''),
        DashboardListModel(
            title: 'YARDING & SELF- RELEASE',
            image: '',
            count: '',
            countNum: '',
            amount: '',
            amountRs: ''),
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

      yield DashboardLoadedState();
    }

    if (event is PriorityFollowEvent) {
      yield PriorityFollowState();
    }
  }
}
