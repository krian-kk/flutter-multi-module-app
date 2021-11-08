import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/utils/base_equatable.dart';

part 'mydeposists_event.dart';
part 'mydeposists_state.dart';

class MydeposistsBloc extends Bloc<MydeposistsEvent, MydeposistsState> {
  MydeposistsBloc() : super(MydeposistsInitial());

  List<CaseListModel> caseList = [];

  Stream<MydeposistsState> mapEventToState(MydeposistsEvent event) async* {
    if (event is MydeposistsInitialEvent) {
      yield MydeposistsLoadingState();

       yield MydeposistsLoadedState();

    }
  }

}
