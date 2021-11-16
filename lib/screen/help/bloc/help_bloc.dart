import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/utils/base_equatable.dart';

part 'help_event.dart';
part 'help_state.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  HelpBloc() : super(HelpInitial());

  @override
  Stream<HelpState> mapEventToState(HelpEvent event) async* {
    if (event is HelpInitialEvent) {
      yield HelpLoadingState();
      yield HelpLoadedState();
    }
  }
}
