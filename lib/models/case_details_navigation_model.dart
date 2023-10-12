
import 'package:origa/src/features/allocation/bloc/allocation_bloc.dart';

class CaseDetailsNaviagationModel {
  CaseDetailsNaviagationModel(this.paramValue, {this.allocationBloc});

  final AllocationBloc? allocationBloc;
  final dynamic paramValue;
}
