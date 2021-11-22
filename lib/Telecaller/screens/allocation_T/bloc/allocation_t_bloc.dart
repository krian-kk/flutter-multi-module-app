import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/allocation_model.dart';
import 'package:origa/models/auto_calling_model.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/string_resource.dart';

part 'allocation_t_event.dart';
part 'allocation_t_state.dart';

class AllocationTBloc extends Bloc<AllocationTEvent, AllocationTState> {
  AllocationTBloc() : super(AllocationTInitial());

  int selectedOption = 0;
  bool isEnableSearchButton = true;
  bool isEnableStartCallButton = false;
  List<AllocationListModel> allocationList = [];
  List<AutoCallingModel> mobileNumberList = [];
  dynamic valuesForDynamicBloc;

  List<String> selectOptions = [
    StringResource.priority,
    StringResource.autoCalling,
  ];

  List<String> listOfContacts = [
    '9765431239',
    '9765431239',
    '9765431239',
    '9765431239',
  ];

  @override
  Stream<AllocationTState> mapEventToState(AllocationTEvent event) async* {
    if (event is AllocationTInitialEvent) {
      yield AllocationTLoadingState();
      // print('--------------NK-------');
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

      mobileNumberList.addAll([
        AutoCallingModel(
          mobileNumber: '9876321230',
          callResponse: 'Declined Call',
        ),
        AutoCallingModel(
          mobileNumber: '9876321230',
        ),
        AutoCallingModel(
          mobileNumber: '9876321230',
        ),
      ]);

      yield AllocationTLoadedState();
    }
    if (event is NavigateSearchPageTEvent) {
      yield NavigateSearchPageTState();

      ///API call---> Post/Put/Delete/Get/Multipart/local
      /// it'll be return some values
      ///valuesForDynamicBloc = API.repository();
      ///
      ///
      ///yikd
    }
  }
}
