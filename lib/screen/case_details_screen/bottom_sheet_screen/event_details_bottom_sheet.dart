import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/event_detail_model.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomEventDetailsBottomSheet extends StatefulWidget {
  final CaseDetailsBloc bloc;
  const CustomEventDetailsBottomSheet(
    this.cardTitle,
    this.bloc, {
    Key? key,
  }) : super(key: key);
  final String cardTitle;

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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetAppbar(
              title: widget.cardTitle,
              padding: const EdgeInsets.fromLTRB(23, 16, 15, 5)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: CustomLoanUserDetails(
              userName: 'DEBASISH PATNAIK',
              userId: 'TVSF_BFRT6458922993',
              userAmount: 397553.67,
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: widget.bloc.expandEvent.length,
            itemBuilder: (context, int index) =>
                expandList(widget.bloc.expandEvent, index),
          )),
          Container(
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
                      // onTap: () => bloc.add(ClickMessageEvent()),
                      cardShape: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  expandList(List<EventExpandModel> expandedList, int index) {
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
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.2),
            //     spreadRadius: 2,
            //     blurRadius: 3,
            //     offset: Offset(0, 3), // changes position of shadow
            //   ),
            // ],
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
                    CustomText(
                      expandedList[index].date,
                      fontSize: FontSize.seventeen,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                    CustomText(
                      expandedList[index].header,
                      fontSize: FontSize.fourteen,
                      fontWeight: FontWeight.w700,
                      color: ColorResource.color000000,
                    ),
                  ],
                ),
                iconColor: ColorResource.color000000,
                collapsedIconColor: ColorResource.color000000,
                children: [
                  CustomText(
                    expandedList[index].colloctorID,
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                  const SizedBox(height: 8),
                  CustomText(
                    Languages.of(context)!.remarks.replaceAll('*', ''),
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                  CustomText(
                    expandedList[index].remarks,
                    fontSize: FontSize.fourteen,
                    fontWeight: FontWeight.w700,
                    color: ColorResource.color000000,
                  ),
                ],
                onExpansionChanged: (bool status) {
                  setState(() {
                    expandedList[index].expanded =
                        !expandedList[index].expanded;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
