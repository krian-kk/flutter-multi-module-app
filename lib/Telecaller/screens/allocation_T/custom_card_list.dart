import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:origa/Telecaller/screens/case_details_telecaller_screen.dart/case_details_telecaller_screen.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/allocation_model.dart';
import 'package:origa/router.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
// import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_text.dart';

import 'bloc/allocation_t_bloc.dart';

class CustomCardList {
  static Widget buildListView(AllocationTBloc bloc) {
    return BlocListener<AllocationTBloc, AllocationTState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is ClickCaseDetailsState) {
          Navigator.pushNamed(context, AppRoutes.caseDetailsScreen,
              arguments: state.paramValue);
        }
      },
      child: BlocBuilder<AllocationTBloc, AllocationTState>(
        bloc: bloc,
        builder: (context, state) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: bloc.allocationList.length,
              itemBuilder: (BuildContext context, int index) {
                int listCount = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (index == 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                '10 ' + Languages.of(context)!.allocation,
                                fontSize: FontSize.fourteen,
                                color: ColorResource.color000000,
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(
                                width: 9.0,
                              ),
                              Container(
                                  height: 20,
                                  width: 20,
                                  child: SvgPicture.asset(ImageResource.star)),
                              const SizedBox(
                                width: 5.0,
                              ),
                              CustomText(
                                bloc.allocationList.length.toString() +
                                    " " +
                                    Languages.of(context)!.hignPriority,
                                fontSize: FontSize.ten,
                                color: ColorResource.color101010,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10, top: 19),
                            child: InkWell(
                              onTap: () => bloc.add(ClickCaseDetailsEvent({
                                'caseID': '618e382004d8d040ac18841b',
                                'isAddress': true
                              })),
                              // () {
                              //   // caseDetailsBottomSheet(context);
                              // },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    (index == bloc.allocationList.length - 1)
                                        ? const EdgeInsets.only(bottom: 90)
                                        : EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: ColorResource.colorffffff,
                                  border: Border.all(
                                      color: ColorResource.colorDADADA,
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      // spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 2.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 2),
                                      child: CustomText(
                                        bloc.allocationList[index].loanID!,
                                        fontSize: FontSize.twelve,
                                        color: ColorResource.color101010,
                                      ),
                                    ),
                                    AppUtils.showDivider(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          23, 0, 10, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                bloc.allocationList[index]
                                                    .amount!,
                                                fontSize: FontSize.eighteen,
                                                color:
                                                    ColorResource.color101010,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const SizedBox(
                                                height: 3.0,
                                              ),
                                              CustomText(
                                                bloc.allocationList[index]
                                                    .customerName!,
                                                fontSize: FontSize.sixteen,
                                                color:
                                                    ColorResource.color101010,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          bloc.allocationList[index].newlyAdded!
                                              ? Container(
                                                  width: 55,
                                                  height: 19,
                                                  // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                  decoration: BoxDecoration(
                                                      color: ColorResource
                                                          .colorD5344C,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Center(
                                                    child: CustomText(
                                                      Languages.of(context)!
                                                          .new_,
                                                      color: ColorResource
                                                          .colorffffff,
                                                      fontSize: FontSize.ten,
                                                      lineHeight: 1,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 2),
                                      child: Wrap(
                                        children: [
                                          for (var item in bloc.listOfContacts)
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10, right: 20),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 17,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorResource.colorF8F9FB,
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: CustomText(
                                                item,
                                                color:
                                                    ColorResource.color484848,
                                                fontSize: FontSize.fourteen,
                                                lineHeight: 1.0,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      child: AppUtils.showDivider(),
                                    ),
                                    //  const SizedBox(height: 5,),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          23, 5, 14, 13),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            Languages.of(context)!.followUpDate,
                                            fontSize: FontSize.fourteen,
                                            color: ColorResource.color101010,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          Row(
                                            children: [
                                              CustomText(
                                                bloc.allocationList[index]
                                                    .date!,
                                                fontSize: FontSize.fourteen,
                                                color:
                                                    ColorResource.color101010,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  CustomText(
                                                    Languages.of(context)!.view,
                                                    fontSize: FontSize.fourteen,
                                                    color: ColorResource
                                                        .color23375A,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  SvgPicture.asset(ImageResource
                                                      .forwardArrow)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: SvgPicture.asset(ImageResource.star),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
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
