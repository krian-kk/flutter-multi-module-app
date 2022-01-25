import 'package:bloc/bloc.dart';
import 'package:origa/base/base_state.dart';
import 'package:origa/screen/message_screen/chat_screen_event.dart';

class ChatScreenBloc extends Bloc<ChatScreenEvent, BaseState> {
  ChatScreenBloc() : super(InitialState());

  @override
  Stream<BaseState> mapEventToState(ChatScreenEvent event) async* {
    if (event is ChatInitialEvent) {
      yield InitialState();
    }
  }
}
