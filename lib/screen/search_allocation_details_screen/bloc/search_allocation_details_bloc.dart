import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/utils/base_equatable.dart';

part 'search_allocation_details_event.dart';
part 'search_allocation_details_state.dart';

class SearchAllocationDetailsBloc
    extends Bloc<SearchAllocationDetailsEvent, SearchAllocationDetailsState> {
  SearchAllocationDetailsBloc() : super(SearchAllocationDetailsInitial());

  @override
  Stream<SearchAllocationDetailsState> mapEventToState(SearchAllocationDetailsEvent event) async* {
    if (event is SearchAllocationDetailsInitialEvent) {
      yield SearchAllocationDetailsLoadingState();
      yield SearchAllocationDetailsLoadedState();
    }

    // if(event is ShowPincodeInAllocationEvent){
    //   yield ShowPincodeInAllocationState();
    //   // widget.bl
    // }
  }
}
