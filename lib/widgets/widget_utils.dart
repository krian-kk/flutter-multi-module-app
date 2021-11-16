import 'package:flutter/material.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
// import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class WidgetUtils {
  static Widget buildListView(AllocationBloc bloc) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: bloc.allocationList.length,
        itemBuilder: (BuildContext context, int index) {
          int listCount = index + 1;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: bloc.showFilterDistance,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 7, top: 3),
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: ColorResource.colorBEC4CF,
                          borderRadius: BorderRadius.circular(75),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 26,
                              width: 26,
                              decoration: const BoxDecoration(
                                color: ColorResource.color23375A,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: CustomText(
                                '$listCount',
                                lineHeight: 1,
                                fontSize: FontSize.twelve,
                                fontWeight: FontWeight.w700,
                                color: ColorResource.colorffffff,
                              )),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            const CustomText(
                              '2.4km 20min',
                              fontSize: FontSize.fourteen,
                              fontWeight: FontWeight.w400,
                              color: ColorResource.color101010,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        )),
                  )),
              if (index == 0 && bloc.showFilterDistance == false)
                Row(
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
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(ImageResource.star)),
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
              Stack(
                children: [
                  Padding(
                    padding: bloc.showFilterDistance
                        ? const EdgeInsets.only(bottom: 20)
                        : const EdgeInsets.only(bottom: 10, top: 19),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.caseDetailsScreen);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: (index == bloc.allocationList.length - 1)
                            ? const EdgeInsets.only(bottom: 70)
                            : EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: ColorResource.colorffffff,
                          border: Border.all(
                              color: ColorResource.colorDADADA, width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            const BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              // spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 1), // changes position of shadow
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 2),
                              child: CustomText(
                                bloc.allocationList[index].loanID!,
                                fontSize: FontSize.twelve,
                                color: ColorResource.color101010,
                              ),
                            ),
                            const Divider(
                              color: ColorResource.colorDADADA,
                              thickness: 0.5,
                            ),
                            // const SizedBox(height: 6.0,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(23, 0, 10, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        bloc.allocationList[index].amount!,
                                        fontSize: FontSize.eighteen,
                                        color: ColorResource.color101010,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const SizedBox(
                                        height: 3.0,
                                      ),
                                      CustomText(
                                        bloc.allocationList[index]
                                            .customerName!,
                                        fontSize: FontSize.sixteen,
                                        color: ColorResource.color101010,
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
                                              color: ColorResource.colorD5344C,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                            child: CustomText(
                                              Languages.of(context)!.new_,
                                              color: ColorResource.colorffffff,
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
                                  horizontal: 15, vertical: 6),
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 12, 15, 12),
                                decoration: BoxDecoration(
                                  color: ColorResource.colorF8F9FB,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomText(
                                  bloc.allocationList[index].address!,
                                  color: ColorResource.color484848,
                                  fontSize: FontSize.fourteen,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Divider(
                                color: ColorResource.colorDADADA,
                                thickness: 0.5,
                              ),
                            ),
                            //  const SizedBox(height: 5,),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(23, 5, 14, 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        bloc.allocationList[index].date!,
                                        fontSize: FontSize.fourteen,
                                        color: ColorResource.color101010,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const Spacer(),
                                      Row(
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
                                          Image.asset(
                                              ImageResource.forwardArrow)
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
                  bloc.showFilterDistance
                      ? const SizedBox()
                      : Container(
                          alignment: Alignment.topRight,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Image.asset(ImageResource.star),
                        ),
                ],
              ),
            ],
          );
        });
  }
}
