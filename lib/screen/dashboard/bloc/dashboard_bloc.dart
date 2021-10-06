import 'package:bloc/bloc.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/utils/base_equatable.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());
  List<DashboardListModel> dashboardList = [];

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is DashboardEvent) {
      yield DashboardLoadingState();

      dashboardList.addAll([
        DashboardListModel(
          title: 'PRIORITY FOLLOW UP',
          image: 'assets/Vector.png',
          count: 'Count',
          countNum: '200',
          amount: 'Amount',
          amountRs: '₹ 3,97,553.67'
        ),
        DashboardListModel(
            title: 'BROKEN PTP',
            image: 'assets/Vector.png',
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'
        ),
        DashboardListModel(
            title: 'UNTOUCHED CASES',
            image: 'assets/Vector.png',
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'
        ),
        DashboardListModel(
            title: 'MY VISITS',
            image: 'assets/Vector.png',
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'
        ),
        DashboardListModel(
            title: 'MY RECEIPTS',
            image: 'assets/Vector.png',
            count: 'Count',
            countNum: '200',
            amount: 'Amount',
            amountRs: '₹ 3,97,553.67'
        ),
        // DashboardListModel(
        //     title: 'MTDRE SOLUTION PROGRESS',
        //     image: 'assets/Vector.png',
        //
        //
        // ),
        // DashboardListModel(
        //   title: 'MY DEPOSISTS',
        //   image: 'assets/Vector.png',
        //
        //
        // ),

      ]);

      yield DashboardLoadedState();
    }
  }
}
