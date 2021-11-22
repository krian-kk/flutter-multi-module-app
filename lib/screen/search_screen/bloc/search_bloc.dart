import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/utils/base_equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchScreenBloc
    extends Bloc<SearchScreenEvent, SearchScreenState> {
  SearchScreenBloc() : super(SearchScreenInitial());

  @override
  Stream<SearchScreenState> mapEventToState(SearchScreenEvent event) async* {
    if (event is SearchScreenInitialEvent) {
      yield SearchScreenLoadingState();
      yield SearchScreenLoadedState();
    }

    // if(event is ShowPincodeInAllocationEvent){
    //   yield ShowPincodeInAllocationState();
    //   // widget.bl
    // }
  }
}
