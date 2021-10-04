import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/allocation_model.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/string_resource.dart';

part 'allocation_event.dart';
part 'allocation_state.dart';

class AllocationBloc extends Bloc<AllocationEvent, AllocationState> {
  AllocationBloc() : super(AllocationInitial());

  String selectedOption = StringResource.priority;

  String selectedDistance = StringResource.all;

  bool showFilterDistance = false;

   List<String> selectOptions = [
    StringResource.priority,
    StringResource.buildRoute,
    StringResource.mapView,
   ];

    List<String> filterBuildRoute = [
    StringResource.all,
    StringResource.under5km,
    StringResource.more5km,
   ];

  List<AllocationListModel> allocationList = [];
  late Position currentLocation;

  @override
  Stream<AllocationState> mapEventToState(AllocationEvent event) async* {
    if (event is AllocationEvent) {
      yield AllocationLoadingState();

      allocationList.addAll([
        AllocationListModel(
          newlyAdded: true,
          customerName: 'Debashish Patnaik',
          amount: '₹ 3,97,553.67',
          address: '2/345, 6th Main Road Gomathipuram, Madurai - 625032',
          date: 'Today, Thu 18 Oct, 2021',
          loanID: 'TVS / TVSF_BFRT6524869550',
          ),
          AllocationListModel(
          newlyAdded: true,
          customerName: 'New User',
          amount: '₹ 5,54,433.67',
          address: '2/345, 6th Main Road, Bangalore - 534544',
          date: 'Thu, Thu 18 Oct, 2021',
          loanID: 'TVS / TVSF_BFRT6524869550',
          ),
          AllocationListModel(
          newlyAdded: true,
          customerName: 'Debashish Patnaik',
          amount: '₹ 8,97,553.67',
          address: '2/345, 1th Main Road Guindy, Chenai - 875032',
          date: 'Sat, Thu 18 Oct, 2021',
          loanID: 'TVS / TVSF_BFRT6524869550',
          ),
      ]); 

      yield AllocationLoadedState();     
    }

     if (event is MapViewEvent) {
      yield MapViewState();
    }
  }


}
