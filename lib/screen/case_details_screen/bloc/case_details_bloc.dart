import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/base/base_state.dart';
//import 'package:origa/base/base_state.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/utils/base_equatable.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';

part 'case_details_event.dart';
part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  List<CustomerMetModel> customerMetList = [
    CustomerMetModel(ImageResource.ptp, StringResource.ptp),
    CustomerMetModel(ImageResource.rtp, StringResource.rtp),
    CustomerMetModel(ImageResource.dispute, StringResource.dispute),
    CustomerMetModel(ImageResource.remainder, StringResource.remainder),
    CustomerMetModel(ImageResource.collections, StringResource.collections),
    CustomerMetModel(ImageResource.ots, StringResource.ots),
  ];
  CaseDetailsBloc() : super(CaseDetailsInitial()) {
    // ignore: void_checks
    on<CaseDetailsEvent>((event, emit) async* {
      if (event is CaseDetailsInitialEvent) {}
    });
  }
}
