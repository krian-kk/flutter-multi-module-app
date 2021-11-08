import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/utils/base_equatable.dart';

part 'yardingandselfrelease_event.dart';
part 'yardingandselfrelease_state.dart';

class YardingandselfreleaseBloc extends Bloc<YardingandselfreleaseEvent, YardingandselfreleaseState> {
  YardingandselfreleaseBloc() : super(YardingandselfreleaseInitial());

  Stream<YardingandselfreleaseState> mapEventToState(YardingandselfreleaseEvent event) async* {
    if (event is YardingandselfreleaseInitialEvent) {
      yield YardingandselfreleaseLoadingState();

       yield YardingandselfreleaseLoadedState();

    }
  }
}
