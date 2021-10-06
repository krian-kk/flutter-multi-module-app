import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/customer_met_model.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  List<CustomerMetGridModel> customerMetGridList = [];
  AddressBloc() : super(AddressInitial()) {
    on<AddressEvent>((event, emit) {
      if (event is AddressInitialEvent) {
        emit.call(AddressLoadingState());
        customerMetGridList.addAll([
          CustomerMetGridModel(ImageResource.ptp, StringResource.ptp),
          CustomerMetGridModel(ImageResource.rtp, StringResource.rtp),
          CustomerMetGridModel(ImageResource.dispute, StringResource.dispute),
          CustomerMetGridModel(
              ImageResource.remainder, StringResource.remainder),
          CustomerMetGridModel(
              ImageResource.collections, StringResource.collections),
          CustomerMetGridModel(ImageResource.ots, StringResource.ots),
        ]);
        emit.call(AddressLoadedState());
      }
    });
  }
}

// @override
//   Stream<AddressState> mapEventToState(AddressEvent event) async* {
//     if (event is AddressInitialEvent) {
//       yield AddressLoadingState();
//       customerMetGridList.addAll([
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//         CustomerMetModel(ImageResource.ptp, StringResource.ptp),
//       ]);
//       yield AddressLoadedState();
//     }
//   }
