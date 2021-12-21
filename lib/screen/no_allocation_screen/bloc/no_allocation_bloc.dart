import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/utils/base_equatable.dart';

part 'no_allocation_event.dart';
part 'no_allocation_state.dart';

class NoAllocationBloc extends Bloc<NoAllocationEvent, NoAllocationState> {
  NoAllocationBloc() : super(NoAllocationInitial()) {
    on<NoAllocationEvent>((event, emit) {
      if (event is NoAllocationInitialEvent) {}
    });
  }
}
