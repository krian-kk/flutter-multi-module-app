import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/multi_details_model.dart';
import 'package:origa/utils/base_equatable.dart';

part 'case_details_event.dart';
part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  double launguageValue = 0;
  List<MultiAddressDetailsModel> multiAddressDetilsList = [];
  List<MultiCallDetailsModel> multiCallDetilsList = [];

  CaseDetailsBloc() : super(CaseDetailsInitial());
  @override
  Stream<CaseDetailsState> mapEventToState(CaseDetailsEvent event) async* {
    if (event is CaseDetailsInitialEvent) {
      yield CaseDetailsLoadingState();
      multiAddressDetilsList.addAll([
        MultiAddressDetailsModel('Address 01',
            '2/345, 6th Main Road Gomathipuram, Madurai - 625032'),
        MultiAddressDetailsModel(
            'Address 02', '2/345, 6th Main Road Gomathipuram, Madurai - 625032')
      ]);
      multiCallDetilsList.addAll([
        MultiCallDetailsModel('PHONE NUMBER 01', '9841021453', true),
        MultiCallDetailsModel('PHONE NUMBER 02', '9841021453', false)
      ]);
      yield CaseDetailsLoadedState();
    }
    if (event is ClickAddressBottomSheetEvent) {
      yield ClickAddressBottomSheetState();
    }
    if (event is ClickCallBottomSheetEvent) {
      yield ClickCallBottomSheetState();
    }
  }
}
