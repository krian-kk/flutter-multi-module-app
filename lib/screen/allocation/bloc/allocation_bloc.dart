import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/utils/base_equatable.dart';

part 'allocation_event.dart';
part 'allocation_state.dart';

class AllocationBloc extends Bloc<AllocationEvent, AllocationState> {
  AllocationBloc() : super(AllocationInitial());

  @override
  Stream<AllocationState> mapEventToState(AllocationEvent event) async* {}
}
