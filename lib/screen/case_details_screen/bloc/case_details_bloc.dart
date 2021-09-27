import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:origa/utils/base_equatable.dart';

part 'case_details_event.dart';
part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  CaseDetailsBloc() : super(CaseDetailsInitial()) {
    on<CaseDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
