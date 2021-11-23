import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/Telecaller/screens/allocation_T/bloc/allocation_t_bloc.dart';
import 'package:origa/Telecaller/screens/case_details_telecaller_screen.dart/case_details_telecaller_screen.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AutoCalling {
  static Widget buildAutoCalling(BuildContext context, AllocationTBloc bloc) {
    List<Widget> _buildRouteFilterOptions() {
      List<Widget> widgets = [];
      bloc.mobileNumberList.asMap().forEach((index, element) {
        widgets.add(
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.fromLTRB(20, 17, 12, 17),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: element.callResponse != null
                  ? ColorResource.colorF6ECEF
                  : ColorResource.colorF8F9FB,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      element.mobileNumber!,
                      color: ColorResource.color484848,
                      fontSize: FontSize.fourteen,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    element.callResponse != null
                        ? SvgPicture.asset(ImageResource.declinedCall)
                        : SvgPicture.asset(ImageResource.activePerson),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        bloc.add(NavigateCaseDetailTEvent());
                      },
                      child: Row(
                        children: [
                          CustomText(
                            Languages.of(context)!.view,
                            fontSize: FontSize.fourteen,
                            color: ColorResource.color23375A,
                            fontWeight: FontWeight.w700,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset(ImageResource.forwardArrow),
                        ],
                      ),
                    )
                  ],
                ),
                if (element.callResponse != null)
                  CustomText(
                    element.callResponse!,
                    color: ColorResource.colorD5344C,
                    fontSize: FontSize.fourteen,
                  ),
              ],
            ),
          ),
        );
      });
      return widgets;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomText(
            Languages.of(context)!.customer.toUpperCase(),
            color: ColorResource.color23375A,
            fontSize: FontSize.ten,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(
            height: 5,
          ),
          LinearPercentIndicator(
            // width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(4),
            animation: true,
            lineHeight: 12.0,
            animationDuration: 2500,
            percent: 0.25,
            // center: Text("80.0%"),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: ColorResource.colorEA6D48,
            backgroundColor: ColorResource.colorD3D7DE,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                '40',
                fontSize: FontSize.sixteen,
                fontWeight: FontWeight.w700,
                color: ColorResource.color23375A,
              ),
              CustomText(
                '400',
                fontSize: FontSize.sixteen,
                fontWeight: FontWeight.w700,
                color: ColorResource.color23375A,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomText(
            Languages.of(context)!.customer.toUpperCase(),
            color: ColorResource.color23375A,
            fontSize: FontSize.fourteen,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ColorResource.colorffffff,
              border: Border.all(color: ColorResource.colorDADADA, width: 0.5),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  // spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 2.0,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                    child: CustomText(
                      'TVS / TVSF_BFRT6524869550',
                      fontSize: FontSize.twelve,
                      color: ColorResource.color101010,
                    ),
                  ),
                ),
                AppUtils.showDivider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(23, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            '₹ 3,97,553.67',
                            fontSize: FontSize.eighteen,
                            color: ColorResource.color101010,
                            fontWeight: FontWeight.w700,
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          CustomText(
                            'customerName',
                            fontSize: FontSize.sixteen,
                            color: ColorResource.color101010,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                        ],
                      ),
                      const Spacer(),
                      // bloc.allocationList[index].newlyAdded!
                      // ?
                      Container(
                        width: 55,
                        height: 19,
                        // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                            color: ColorResource.colorD5344C,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: CustomText(
                            Languages.of(context)!.new_,
                            color: ColorResource.colorffffff,
                            fontSize: FontSize.ten,
                            lineHeight: 1,
                          ),
                        ),
                      ),
                      // : const SizedBox(),
                    ],
                  ),
                ),
                Column(
                  children: _buildRouteFilterOptions(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: AppUtils.showDivider(),
                ),
                InkWell(
                  onTap: () {
                    bloc.add(NavigateCaseDetailTEvent());
                  },
                  child: SizedBox(
                    child: Column(
                      children: [
                        CustomText(
                          Languages.of(context)!.caseView.toUpperCase(),
                          fontSize: FontSize.fourteen,
                          color: ColorResource.color23375A,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        SvgPicture.asset(
                          ImageResource.downArrow,
                          width: 15,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static caseDetailsBottomSheet(BuildContext buildContext) {
    showModalBottomSheet(
        isDismissible: false,
        // enableDrag: false,
        isScrollControlled: true,
        context: buildContext,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        backgroundColor: ColorResource.colorFFFFFF,
        builder: (BuildContext context) {
          // return SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.89,
          // );
          return CaseDetailsTelecallerScreen();
        });
  }
}
