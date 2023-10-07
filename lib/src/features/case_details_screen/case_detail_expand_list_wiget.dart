import 'package:design_system/color_resources.dart';
import 'package:design_system/fonts.dart';
import 'package:domain_models/response_models/allocation/contractor_all_information_model.dart';
import 'package:flutter/material.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/singleton.dart';
import 'package:origa/src/features/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/date_format_utils.dart';
import 'package:origa/widgets/custom_text.dart';

class ListOfCaseDetails {
  static Widget listOfDetails(BuildContext context,
      {required String title,
      required CaseDetailsBloc bloc,
      Widget? repaymentDetailsWidget,
      bool isInitialExpand = false,
      bool isLoanDetails = false,
      bool isAttributeDetails = false,
      bool isCustomerDetails = false,
      bool isCustomerContactDetails = false,
      bool isAuditDetails = false,
      bool isRepaymentDetails = false,
      required List<Widget> child}) {
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
          children: child.isEmpty
              ? [
                  isRepaymentDetails
                      ? repaymentDetailsWidget!
                      : const SizedBox(),
                  isLoanDetails ? loanDetails(bloc, context) : const SizedBox(),
                  isCustomerDetails
                      ? agentDetails(bloc, context)
                      : const SizedBox(),
                  isAttributeDetails
                      ? attributeDetails(bloc, context)
                      : const SizedBox(),
                  isCustomerContactDetails
                      ? contactDetails(bloc, context)
                      : const SizedBox(),
                  isAuditDetails
                      ? auditDetails(bloc, context)
                      : const SizedBox(),
                ]
              : child,
        ),
      ),
    );
  }

  static Widget textFieldView(
      {required String title, required dynamic value, bool? isSingleLines}) {
    Widget widget;
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
            value: bloc.caseDetailsAPIValue.caseDetails?.loanAmt.toString()),
        Row(
          children: <Widget>[
            Flexible(
              child: SizedBox(
                child: ListOfCaseDetails.textFieldView(
                    title: Languages.of(context)!.loanDuration,
                    value: bloc.caseDetailsAPIValue.caseDetails?.loanDuration
                        .toString()),
              ),
            ),
            bloc.caseDetailsAPIValue.caseDetails?.loanDuration != null
                ? const SizedBox(width: 22)
                : const SizedBox(),
            Flexible(
              child: SizedBox(
                child: ListOfCaseDetails.textFieldView(
                    title: Languages.of(context)!.pos,
                    value:
                        bloc.caseDetailsAPIValue.caseDetails?.pos.toString()),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: ListOfCaseDetails.textFieldView(
                  title: Languages.of(context)!.schemeCode,
                  value: bloc.caseDetailsAPIValue.caseDetails?.schemeCode
                      .toString()),
            ),
            bloc.caseDetailsAPIValue.caseDetails?.schemeCode != null
                ? const SizedBox(width: 22)
                : const SizedBox(),
            Flexible(
              child: ListOfCaseDetails.textFieldView(
                  title: Languages.of(context)!.emiStartDate,
                  value: DateFormatUtils2.followUpDateFormat2(bloc
                          .caseDetailsAPIValue.caseDetails?.emiStartDate
                          .toString() ??
                      '')),
            ),
          ],
        ),
        // ListOfCaseDetails.textFieldView(
        //     title: Languages.of(context)!.bankName.replaceAll('*', ''),
        //     value: bloc.caseDetailsAPIValue.caseDetails?.bankName
        //         .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.product,
            value: bloc.caseDetailsAPIValue.caseDetails?.product.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.batchNo,
            value: bloc.caseDetailsAPIValue.caseDetails?.batchNo.toString()),

        // Extra text field
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.dateOfLoanDisbursement,
            value:
                bloc.caseDetailsAPIValue.caseDetails?.loanDisbDate.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.tos,
            value: bloc.caseDetailsAPIValue.caseDetails?.tos.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.emiAmount,
            value: bloc.caseDetailsAPIValue.caseDetails?.emiAmt.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.noOfPendingEMI,
            value: bloc.caseDetailsAPIValue.caseDetails?.pendingEmi.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.penaltyAmount,
            value: bloc.caseDetailsAPIValue.caseDetails?.amtPenalty.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.odInterest,
            value: bloc.caseDetailsAPIValue.caseDetails?.odInt.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.assetDetails,
            value:
                bloc.caseDetailsAPIValue.caseDetails?.assetDetails.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.coLender,
            value: bloc.caseDetailsAPIValue.caseDetails?.coLender.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.employerBusinessEntity,
            value:
                bloc.caseDetailsAPIValue.caseDetails?.empBusEntity.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.lastPaymentDate,
            value: bloc.caseDetailsAPIValue.caseDetails?.lastPaymentDate
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.sourcingRmName,
            value: bloc.caseDetailsAPIValue.caseDetails?.sourcingRmName
                .toString()),

        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.fatherSpouseName,
            value: bloc.caseDetailsAPIValue.caseDetails?.fatherSpouseName
                .toString()),

        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.lastPaymentMode,
            value: bloc.caseDetailsAPIValue.caseDetails?.lastPaymentMode
                .toString()),

        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.zone,
            value: bloc.caseDetailsAPIValue.caseDetails?.zone.toString()),

        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.dpd,
            value: bloc.caseDetailsAPIValue.caseDetails?.dpd.toString()),

        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.language,
            value: bloc.caseDetailsAPIValue.caseDetails?.language.toString()),

        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.lastPaidAmount,
            value: bloc.caseDetailsAPIValue.caseDetails?.lastPaidAmount
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.riskRanking,
            value:
                bloc.caseDetailsAPIValue.caseDetails?.riskRanking.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.reviewFlag,
            value: bloc.caseDetailsAPIValue.caseDetails?.reviewFlag.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.location,
            value: bloc.caseDetailsAPIValue.caseDetails?.location.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.agency,
            value: bloc.caseDetailsAPIValue.caseDetails?.agency.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.customerID,
            value: bloc.caseDetailsAPIValue.caseDetails?.customerId.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.minDueAmount,
            value: bloc.caseDetailsAPIValue.caseDetails?.minDueAmt.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.cardOutstanding,
            value: bloc.caseDetailsAPIValue.caseDetails?.cardOs.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.statementDate,
            value:
                bloc.caseDetailsAPIValue.caseDetails?.statementDate.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.dueDate,
            value: bloc.caseDetailsAPIValue.caseDetails?.dueDate.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.cardStatus,
            value: bloc.caseDetailsAPIValue.caseDetails?.cardStatus.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.lastBilledAmount,
            value:
                bloc.caseDetailsAPIValue.caseDetails?.lastBilledAmt.toString()),

        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.chassisNo,
            value: bloc.caseDetailsAPIValue.caseDetails?.chassisNo.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.modelMake,
            value: bloc.caseDetailsAPIValue.caseDetails?.modelMake.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.riskBucket,
            value: bloc.caseDetailsAPIValue.caseDetails?.riskBucket.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.ref1,
            value: bloc.caseDetailsAPIValue.caseDetails?.ref1.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.ref2,
            value: bloc.caseDetailsAPIValue.caseDetails?.ref2.toString()),
      ],
    );
  }

  static Widget agentDetails(CaseDetailsBloc bloc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.primaryUser,
            value: bloc.caseDetailsAPIValue.caseDetails?.agent?.agentRef
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.secondaryUser,
            value: bloc.caseDetailsAPIValue.caseDetails?.agent?.secondaryAgent
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.agentName,
            value:
                bloc.caseDetailsAPIValue.caseDetails?.agent?.name.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.agentType,
            value:
                bloc.caseDetailsAPIValue.caseDetails?.agent?.type.toString()),
      ],
    );
  }

  static Widget attributeDetails(CaseDetailsBloc bloc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.state,
            value: bloc.caseDetailsAPIValue.caseDetails?.attr?.first.state
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.city,
            value: bloc.caseDetailsAPIValue.caseDetails?.attr?.first.city
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.pincode,
            value: bloc.caseDetailsAPIValue.caseDetails?.attr?.first.pincode
                .toString()),
      ],
    );
  }

  static Widget contactDetails(CaseDetailsBloc bloc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
          bloc.caseDetailsAPIValue.caseDetails?.contact?.length ?? 0, (index) {
        String ctype;
        String value =
            bloc.caseDetailsAPIValue.caseDetails?.contact?[index].value ?? '';
        if (bloc.caseDetailsAPIValue.caseDetails?.contact?[index].cType!
                .toLowerCase() ==
            'residence address') {
          ctype = Languages.of(context)!.residenceAddress;
        } else if (bloc.caseDetailsAPIValue.caseDetails?.contact?[index].cType!
                .toLowerCase() ==
            'office address') {
          ctype = Languages.of(context)!.officeaddress;
        } else if (bloc.caseDetailsAPIValue.caseDetails?.contact?[index].cType!
                .toLowerCase() ==
            'mobile') {
          ContractorResult? informationModel =
              Singleton.instance.contractorInformations;
          if (informationModel?.cloudTelephony == true &&
              informationModel?.contactMasking == true) {
            value = value.replaceRange(2, 7, 'XXXXX');
          }
          ctype = Languages.of(context)!.mobile;
        } else if (bloc.caseDetailsAPIValue.caseDetails?.contact?[index].cType!
                    .toLowerCase() ==
                'email' ||
            bloc.caseDetailsAPIValue.caseDetails?.contact?[index].cType!
                    .toLowerCase() ==
                'email id') {
          ctype = Languages.of(context)!.email;
        } else {
          ctype =
              bloc.caseDetailsAPIValue.caseDetails?.contact?[index].cType ?? '';
        }
        final Widget widget =
            ListOfCaseDetails.textFieldView(title: ctype, value: value);
        return widget;
      }),
    );
  }

  static Widget auditDetails(CaseDetailsBloc bloc, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.createdBy,
            value:
                bloc.caseDetailsAPIValue.caseDetails?.audit?.crBy.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.createdAt,
            value: DateFormatUtils2.followUpDateFormat2(
                bloc.caseDetailsAPIValue.caseDetails?.audit?.crAt.toString() ??
                    '')),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.updatedBy,
            value:
                bloc.caseDetailsAPIValue.caseDetails?.audit?.upBy.toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.updatedAt,
            value: DateFormatUtils2.followUpDateFormat2(
                bloc.caseDetailsAPIValue.caseDetails?.audit?.upAt.toString() ??
                    '')),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.allocatedBy,
            value: bloc.caseDetailsAPIValue.caseDetails?.audit?.allocatedBy
                .toString()),
        ListOfCaseDetails.textFieldView(
            title: Languages.of(context)!.allocatedAt,
            value: DateFormatUtils2.followUpDateFormat2(bloc
                    .caseDetailsAPIValue.caseDetails?.audit?.allocatedAt
                    .toString() ??
                '')),
      ],
    );
  }
}
