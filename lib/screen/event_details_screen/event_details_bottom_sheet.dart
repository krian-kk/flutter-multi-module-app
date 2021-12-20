import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/event_details_api_model/result.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class CustomEventDetailsBottomSheet extends StatefulWidget {
  final CaseDetailsBloc bloc;
  const CustomEventDetailsBottomSheet(this.cardTitle, this.bloc,
      {Key? key, required this.customeLoanUserWidget})
      : super(key: key);
  final String cardTitle;
  final Widget customeLoanUserWidget;

  @override
  State<CustomEventDetailsBottomSheet> createState() =>
      _CustomEventDetailsBottomSheetState();
}

class _CustomEventDetailsBottomSheetState
    extends State<CustomEventDetailsBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.89,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetAppbar(
                title: widget.cardTitle,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15)
                        .copyWith(bottom: 5),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: widget.customeLoanUserWidget,
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: ListView.builder(
                itemCount: widget.bloc.offlineEventDetailsListValue.length,
                itemBuilder: (context, int index) =>
                    expandList(widget.bloc.offlineEventDetailsListValue, index),
              )),
            ],
          ),
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              color: ColorResource.colorFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: ColorResource.color000000.withOpacity(.25),
                  blurRadius: 2.0,
                  offset: const Offset(1.0, 1.0),
                ),
              ],
            ),
            width: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    child: CustomButton(
                      Languages.of(context)!.okay.toUpperCase(),
                      onTap: () => Navigator.pop(context),
                      fontSize: FontSize.sixteen,
                      fontWeight: FontWeight.w600,
                      cardShape: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  expandList(List<EventDetailsResultModel> expandedList, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12, left: 18, right: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: ColorResource.colorF4E8E4,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 3, 14, 15),
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: const EdgeInsetsDirectional.all(0),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.centerLeft,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (expandedList[index].date != null)
                      CustomText(
                        DateFormat('dd MMMM yyyy')
                            .format(DateTime.parse(
                                expandedList[index].date.toString()))
                            .toString()
                            .toUpperCase(),
                        fontSize: FontSize.seventeen,
                        fontWeight: FontWeight.w700,
                        color: ColorResource.color000000,
                      ),
                    CustomText(
                      expandedList[index].eventType.toString().toUpperCase(),
                      fontSize: FontSize.fourteen,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  ],
                ),
                iconColor: ColorResource.color000000,
                collapsedIconColor: ColorResource.color000000,
                children: [
                  if (expandedList[index].date != null)
                    CustomText(
                      expandedList[index].caseId.toString().toUpperCase(),
                      fontSize: FontSize.fourteen,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  const SizedBox(height: 8),
                  if (expandedList[index].date != null)
                    CustomText(
                      Languages.of(context)!.mode.toString().toUpperCase(),
                      fontSize: FontSize.fourteen,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  if (expandedList[index].mode != null)
                    CustomText(
                      expandedList[index].mode.toString().toUpperCase(),
                      fontSize: FontSize.fourteen,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  CustomText(
                    Languages.of(context)!
                        .remarks
                        .replaceAll('*', '')
                        .toUpperCase(),
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                  CustomText(
                    expandedList[index].remarks ?? '-',
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
