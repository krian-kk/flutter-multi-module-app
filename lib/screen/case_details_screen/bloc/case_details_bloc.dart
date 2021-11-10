import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:origa/http/response/case_details_response.dart';
import 'package:origa/models/case_details_api_model/case_details_api_model.dart';
import 'package:origa/models/multi_details_model.dart';
import 'package:origa/utils/base_equatable.dart';

part 'case_details_event.dart';
part 'case_details_state.dart';

class CaseDetailsBloc extends Bloc<CaseDetailsEvent, CaseDetailsState> {
  double launguageValue = 0;

  List<MultiAddressDetailsModel> multiAddressDetilsList = [];
  List<MultiCallDetailsModel> multiCallDetilsList = [];
  CaseDetailsApiModel caseDetailsResult = CaseDetailsApiModel();

  late TextEditingController loanAmountController = TextEditingController();
  late TextEditingController bankNameController = TextEditingController();
  late TextEditingController emiStartDateController = TextEditingController();
  late TextEditingController loanDurationController = TextEditingController();
  late TextEditingController posController = TextEditingController();
  late TextEditingController schemeCodeController = TextEditingController();
  late TextEditingController productController = TextEditingController();
  late TextEditingController batchNoController = TextEditingController();

  CaseDetailsBloc() : super(CaseDetailsInitial());
  @override
  Stream<CaseDetailsState> mapEventToState(CaseDetailsEvent event) async* {
    if (event is CaseDetailsInitialEvent) {
      yield CaseDetailsLoadingState();
      Map<String, dynamic> caseDetailsData =
          await getCaseDetailsData('5f80375a86527c46deba2e5d');
      if (caseDetailsData["success"] == true) {
        Map<String, dynamic> jsonData = caseDetailsData["data"];

        caseDetailsResult = CaseDetailsApiModel.fromJson(jsonData);

        // print(caseDetailsDatas);

        loanAmountController.text =
            caseDetailsResult.result?.caseDetails!.loanAmt.toString() as String;
        loanDurationController.text =
            caseDetailsResult.result?.caseDetails!.loanDuration.toString()
                as String;
        posController.text =
            caseDetailsResult.result?.caseDetails!.pos.toString() as String;
        schemeCodeController.text =
            caseDetailsResult.result?.caseDetails!.schemeCode.toString()
                as String;
        emiStartDateController.text =
            caseDetailsResult.result?.caseDetails!.emiStartDate.toString()
                as String;
        bankNameController.text =
            caseDetailsResult.result?.caseDetails!.bankName.toString()
                as String;
        productController.text =
            caseDetailsResult.result?.caseDetails!.product.toString() as String;
        batchNoController.text =
            caseDetailsResult.result?.caseDetails!.batchNo.toString() as String;

        // yield SevenDaysLoadedState();
      } else {
        // message = weatherData["data"];
        // yield SevenDaysFailureState();
      }
      multiAddressDetilsList.addAll([
        MultiAddressDetailsModel('Address 01',
            '2/345, 6th Main Road Gomathipuram, Madurai - 625032'),
        MultiAddressDetailsModel(
            'Address 02', '2/345, 6th Main Road Gomathipuram, Madurai - 625032')
      ]);
      multiCallDetilsList.addAll([
        MultiCallDetailsModel('PHONE NUMBER 01', '9841021453', true),
        MultiCallDetailsModel('PHONE NUMBER 02', '9841021453', false)
      ]);

      yield CaseDetailsLoadedState();
    }
    if (event is ClickAddressBottomSheetEvent) {
      yield ClickAddressBottomSheetState();
    }
    if (event is ClickCallBottomSheetEvent) {
      yield ClickCallBottomSheetState();
    }
  }
}
