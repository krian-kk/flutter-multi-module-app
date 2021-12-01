import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:origa/models/case_details_api_model/case_details_api_model.dart';
import 'package:origa/utils/base_equatable.dart';
part 'casedetails_telecaller_event.dart';
part 'casedetails_telecaller_state.dart';

class CasedetailsTelecallerBloc
    extends Bloc<CasedetailsTelecallerEvent, CasedetailsTelecallerState> {
  // Case Details Screen

  CaseDetailsApiModel caseDetailsResult = CaseDetailsApiModel();

  late TextEditingController loanAmountController = TextEditingController();
  late TextEditingController bankNameController = TextEditingController();
  late TextEditingController emiStartDateController = TextEditingController();
  late TextEditingController loanDurationController = TextEditingController();
  late TextEditingController posController = TextEditingController();
  late TextEditingController schemeCodeController = TextEditingController();
  late TextEditingController productController = TextEditingController();
  late TextEditingController batchNoController = TextEditingController();
  CasedetailsTelecallerBloc() : super(CasedetailsTelecallerInitial()) {
    on<CasedetailsTelecallerEvent>((event, emit) async {
      // Address Details Screen

      if (event is CaseDetailsTelecallerInitialEvent) {
        emit.call(CaseDetailsTelecallerLoadingState());
        loanAmountController.text = '67793';
        loanDurationController.text = '24';
        posController.text = '128974';
        schemeCodeController.text = '34';
        emiStartDateController.text = '08-09-2017';
        bankNameController.text = 'TVS';
        productController.text = '2W';
        batchNoController.text = 'HAR_50CASES-16102020_015953';

        final result = await Connectivity().checkConnectivity();
        if (result == ConnectivityResult.none) {
        } else {
          // Map<String, dynamic> caseDetailsData =
          //     await getCaseDetailsData('5f80375a86527c46deba2e5d');

          // if (caseDetailsData["success"] == true) {
          //   Map<String, dynamic> jsonData = caseDetailsData["data"];
          //   print(jsonData);

          //   caseDetailsResult = CaseDetailsApiModel.fromJson(jsonData);
          //   caseDetailsApiBox.clear();
          //   caseDetailsApiBox.add(caseDetailsResult.toJson());
          //   if (caseDetailsApiBox.isEmpty) {
          //     print("is Empty");
          //   } else {
          //     // loanAmountController.text = caseDetailsApiBox
          //     //     .getAt(0)['result']['caseDetails']['loanAmt']
          //     //     .toString();
          //   }

          //   loanAmountController.text =
          //       caseDetailsResult.result?.caseDetails!.loanAmt.toString()
          //           as String;
          //   loanDurationController.text =
          //       caseDetailsResult.result?.caseDetails!.loanDuration.toString()
          //           as String;
          //   posController.text =
          //       caseDetailsResult.result?.caseDetails!.pos.toString() as String;
          //   schemeCodeController.text =
          //       caseDetailsResult.result?.caseDetails!.schemeCode.toString()
          //           as String;
          //   emiStartDateController.text =
          //       caseDetailsResult.result?.caseDetails!.emiStartDate.toString()
          //           as String;
          //   bankNameController.text =
          //       caseDetailsResult.result?.caseDetails!.bankName.toString()
          //           as String;
          //   productController.text =
          //       caseDetailsResult.result?.caseDetails!.product.toString()
          //           as String;
          //   batchNoController.text =
          //       caseDetailsResult.result?.caseDetails!.batchNo.toString()
          //           as String;

          // yield SevenDaysLoadedState();
          // } else {
          //   // message = weatherData["data"];
          //   // yield SevenDaysFailureState();
          // }
        }
        emit.call(CaseDetailsTelecallerLoadedState());
      }

      if (event is ClickCallBottomSheetTelecallerEvent) {
        emit.call(ClickCallTelecallerBottomSheetState());
      }
    });
  }
}
