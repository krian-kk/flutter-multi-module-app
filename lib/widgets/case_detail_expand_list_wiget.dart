import 'package:flutter/material.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/widgets/custom_text.dart';

import '../languages/app_languages.dart';
import '../utils/app_utils.dart';
import '../utils/color_resource.dart';
import '../utils/date_formate_utils.dart';
import '../utils/font.dart';

class ListOfCaseDetails {
  static Widget listOfDetails(
    BuildContext context, {
    required String title,
    required CaseDetailsBloc bloc,
    Widget? repaymentDetailsWidget,
    bool isInitialExpand = false,
    bool isLoanDetails = false,
    bool isAttributeDetails = false,
    bool isCustomerDetails = false,
    bool isCustomerContactDetails = false,
    bool isAuditDetails = false,
    bool isRepaymentDetails = false,
  }) {
    return ListTileTheme(
      contentPadding: const EdgeInsets.all(0),
      minVerticalPadding: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: ColorResource.color666666),
        borderRadius: BorderRadius.circular(65.0),
      ),
      tileColor: ColorResource.colorF7F8FA,
      selectedTileColor: ColorResource.colorE5E5E5,
      selectedColor: ColorResource.colorE5E5E5,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isInitialExpand,
          onExpansionChanged: (val) {
            // print("isLoanDetails -----> $isLoanDetails");
          },
          tilePadding: const EdgeInsetsDirectional.only(start: 20, end: 20),
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          expandedAlignment: Alignment.centerLeft,
          title: CustomText(
            title,
            fontSize: FontSize.eighteen,
            fontWeight: FontWeight.w700,
            lineHeight: 1,
          ),
          iconColor: ColorResource.color000000,
          collapsedIconColor: ColorResource.color000000,
          children: [
            isRepaymentDetails ? repaymentDetailsWidget! : const SizedBox(),
            isLoanDetails ? loanDetails(bloc, context) : const SizedBox(),
            isCustomerDetails ? agentDetails(bloc, context) : const SizedBox(),
            isAttributeDetails
                ? attributeDetails(bloc, context)
                : const SizedBox(),
            isCustomerContactDetails
                ? contactDetails(bloc, context)
                : const SizedBox(),
            isAuditDetails ? auditDetails(bloc, context) : const SizedBox(),
          ],
        ),
      ),
    );
  }

  static Widget textFieldView(
      {required String title, required dynamic value, bool? isSingleLines}) {
    Widget widget;
    // return widget;
    switch (value) {
      case 'null':
        widget = const SizedBox();
        break;
      case '':
        widget = const SizedBox();
        break;
      case null:
        widget = const SizedBox();
        break;
      default:
        widget = Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  color: ColorResource.color666666,
                  fontSize: FontSize.twelve,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 4),
                  child: CustomText(
                    value,
                    color: ColorResource.color333333,
                    isSingleLine: isSingleLines ?? false,
                  ),
                ),
                AppUtils.showDivider2(),
              ],
            ));
        break;
    }
    return widget;
  }

  static Widget loanDetails(CaseDetailsBloc bloc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.loanAmount,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.loanAmt
                .toString()),
        Row(
          children: <Widget>[
            Flexible(
              child: SizedBox(
                child: ListOfCaseDetails.textFieldView(
                    title: Languages.of(context)!.loanDuration,
                    value: bloc
                        .caseDetailsAPIValue.result?.caseDetails?.loanDuration
                        .toString()),
              ),
            ),
            const SizedBox(width: 22),
            Flexible(
              child: SizedBox(
                child: ListOfCaseDetails.textFieldView(
                    title: Languages.of(context)!.pos,
                    value: bloc.caseDetailsAPIValue.result?.caseDetails?.pos
                        .toString()),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: ListOfCaseDetails.textFieldView(
                  title: Languages.of(context)!.schemeCode,
                  value: bloc
                      .caseDetailsAPIValue.result?.caseDetails?.schemeCode
                      .toString()),
            ),
            const SizedBox(width: 22),
            Flexible(
              child: ListOfCaseDetails.textFieldView(
                  title: Languages.of(context)!.emiStartDate,
                  value: DateFormateUtils2.followUpDateFormate2(bloc
                          .caseDetailsAPIValue.result?.caseDetails?.emiStartDate
                          .toString() ??
                      '')),
            ),
          ],
        ),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.bankName.replaceAll('*', ''),
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.bankName
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.product,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.product
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.batchNo,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.batchNo
                .toString()),

        // Extra text field
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.dateOfLoanDisbursement,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.loanDisbDate
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.tos,
            value:
                bloc.caseDetailsAPIValue.result?.caseDetails?.tos.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.emiAmount,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.emiAmt
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.noOfPendingEMI,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.pendingEmi
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.penaltyAmount,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.amtPenalty
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.odInterest,
            value:
                bloc.caseDetailsAPIValue.result?.caseDetails?.odInt.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.assetDetails,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.assetDetails
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.coLender,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.coLender
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.employerBusinessEntity,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.empBusEntity
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.lastPaymentDate,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.lastPaymentDate
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.sourcingRmName,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.sourcingRmName
                .toString()),

        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.lastPaidAmount,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.lastPaidAmount
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.riskRanking,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.riskRanking
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.reviewFlag,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.reviewFlag
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.location,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.location
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.agency,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.agency
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.customerID,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.customerId
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.minDueAmount,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.minDueAmt
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.cardOutstanding,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.cardOs
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.statementDate,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.statementDate
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.dueDate,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.dueDate
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.cardStatus,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.cardStatus
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.lastBilledAmount,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.lastBilledAmt
                .toString()),

        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.chassisNo,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.chassisNo
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.modelMake,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.modelMake
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.riskBucket,
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.riskBucket
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.ref1,
            value:
                bloc.caseDetailsAPIValue.result?.caseDetails?.ref1.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.ref2,
            value:
                bloc.caseDetailsAPIValue.result?.caseDetails?.ref2.toString()),
      ],
    );
  }

  static Widget agentDetails(CaseDetailsBloc bloc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListOfCaseDetails.textFieldView(
            title: "Primary User",
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.agent?.agentRef
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: "Secondary User",
            value: bloc
                .caseDetailsAPIValue.result?.caseDetails?.agent?.secondaryAgent
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: "Agent Name",
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.agent?.name
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: "Agent Type",
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.agent?.type
                .toString()),
      ],
    );
  }

  static Widget attributeDetails(CaseDetailsBloc bloc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListOfCaseDetails.textFieldView(
            title: 'State',
            value: bloc
                .caseDetailsAPIValue.result?.caseDetails?.attr?.first.state
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: 'City',
            value: bloc
                .caseDetailsAPIValue.result?.caseDetails?.attr?.first.city
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: 'Pincode',
            value: bloc
                .caseDetailsAPIValue.result?.caseDetails?.attr?.first.pincode
                .toString()),
      ],
    );
  }

  static Widget contactDetails(CaseDetailsBloc bloc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
          bloc.caseDetailsAPIValue.result?.caseDetails?.contact?.length ?? 0,
          (index) {
        return ListOfCaseDetails.textFieldView(
            title: bloc.caseDetailsAPIValue.result?.caseDetails?.contact?[index]
                    .cType ??
                '',
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.contact?[index]
                    .value ??
                '');
      }),
    );
  }

  static Widget auditDetails(CaseDetailsBloc bloc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListOfCaseDetails.textFieldView(
            title: 'Created By',
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.audit?.crBy
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: 'Created At',
            value: DateFormateUtils2.followUpDateFormate2(bloc
                    .caseDetailsAPIValue.result?.caseDetails?.audit?.crAt
                    .toString() ??
                '')),
        ListOfCaseDetails.textFieldView(
            title: 'Updated By',
            value: bloc.caseDetailsAPIValue.result?.caseDetails?.audit?.upBy
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: 'Updated At',
            value: DateFormateUtils2.followUpDateFormate2(bloc
                    .caseDetailsAPIValue.result?.caseDetails?.audit?.upAt
                    .toString() ??
                '')),
        ListOfCaseDetails.textFieldView(
            title: 'Allocated By',
            value: bloc
                .caseDetailsAPIValue.result?.caseDetails?.audit?.allocatedBy
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: 'Allocated At',
            value: DateFormateUtils2.followUpDateFormate2(bloc
                    .caseDetailsAPIValue.result?.caseDetails?.audit?.allocatedAt
                    .toString() ??
                '')),
      ],
    );
  }
}
