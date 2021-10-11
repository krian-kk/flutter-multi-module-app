import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:origa/models/allocation_model.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_text.dart';


class CaseLists {
  static Widget buildListView(DashboardBloc bloc) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: bloc.caseList.length,
        itemBuilder: (BuildContext context, int index) {
        int listCount = index +1;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorResource.colorffffff,
                    border:
                        Border.all(color: ColorResource.colorDADADA, width: 0.5),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 2.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                        child: CustomText(
                          bloc.caseList[index].loanID!,
                          fontSize: FontSize.twelve,
                          color: ColorResource.color101010,
                        ),
                      ),
                      Divider(
                        color: ColorResource.colorDADADA,
                        thickness: 0.5,
                      ),
                      // const SizedBox(height: 6.0,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(23, 0, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  bloc.caseList[index].amount!,
                                  fontSize: FontSize.eighteen,
                                  color: ColorResource.color101010,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(
                                  height: 3.0,
                                ),
                                CustomText(
                                  bloc.caseList[index].customerName!,
                                  fontSize: FontSize.sixteen,
                                  color: ColorResource.color101010,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            const Spacer(),
                            bloc.caseList[index].newlyAdded!
                                ? Container(
                                    width: 55,
                                    height: 19,
                                    // padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                        color: ColorResource.colorD5344C,
                                        borderRadius: BorderRadius.circular(30)),
                                    child: Center(
                                      child: CustomText(
                                        StringResource.new_,
                                        color: ColorResource.colorffffff,
                                        fontSize: FontSize.ten,
                                        lineHeight: 1,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 12, 15, 12),
                          decoration: BoxDecoration(
                            color: ColorResource.colorF8F9FB,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText(
                            bloc.caseList[index].address!,
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
                        padding: EdgeInsets.fromLTRB(23, 5, 14, 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              StringResource.followUpDate,
                              fontSize: FontSize.fourteen,
                              color: ColorResource.color101010,
                              fontWeight: FontWeight.w400,
                            ),
                            Row(
                              children: [
                                CustomText(
                                  bloc.caseList[index].date!,
                                  fontSize: FontSize.fourteen,
                                  color: ColorResource.color101010,
                                  fontWeight: FontWeight.w700,
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    await Navigator.pushNamed(
                                        context, AppRoutes.caseDetailsScreen);
                                  },
                                  child: Row(
                                    children: [
                                      CustomText(
                                        StringResource.view,
                                        fontSize: FontSize.fourteen,
                                        color: ColorResource.color23375A,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset(ImageResource.forwardArrow)
                                    ],
                                  ),
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
            ],
          );
        });
  }
}