import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:design_system/strings.dart';
import 'package:design_system/widgets/toolbarRectBtn_widget.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:languages/language_english.dart';
import 'package:origa/gen/assets.gen.dart';
import 'package:origa/src/features/allocation/presentation/priority_list_view/priority_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/date_format_utils.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/case_status_widget.dart';
import 'package:origa/widgets/custom_text.dart';

class AllocationView extends StatefulWidget {
  const AllocationView({Key? key}) : super(key: key);

  @override
  State<AllocationView> createState() => _AllocationViewState();
}

class _AllocationViewState extends State<AllocationView> {
  final _pagingController =
      PagingController<int, PriorityCaseListModel>(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      BlocProvider.of<PriorityBloc>(context).add(LoadPriorityList(pageKey));
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PriorityBloc, PriorityState>(
        listener: (context, state) {
          if (state is PriorityCompletedState) {
            if (state.nextPageKey == null) {
              _pagingController.appendLastPage(state.listItems);
            } else {
              _pagingController.appendPage(state.listItems, state.nextPageKey);
            }
          }
        },
        child: Scaffold(
            backgroundColor: ColorResourceDesign.primaryColor,
            body: PagedListView<int, PriorityCaseListModel>(
                pagingController: _pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<PriorityCaseListModel>(
                  itemBuilder: (context, item, index) =>
                      PriorityCaseItemWidget(item, index),
                )
                // body: Column(
                //   children: [
                //     gapH8,
                //     // _officeChecker(),
                //     gapH12,
                //     // _searchByPincode(),
                //     gapH16,
                //     _buttonList(),
                //     gapH16,
                //     // _allocationBloc(),
                //     PagedListView<int, PriorityCaseListModel>(
                //         pagingController: _pagingController,
                //         builderDelegate:
                //             PagedChildBuilderDelegate<PriorityCaseListModel>(
                //           itemBuilder: (context, item, index) => _allocationBloc(),
                //         ))
                //   ],
                )));
  }

  Widget _officeChecker() {
    return Container(
        width: 400,
        height: 50,
        decoration: BoxDecoration(
          color: ColorResourceDesign.whiteColor,
          border: Border.all(
            color: ColorResourceDesign.whiteGray,
          ),
          borderRadius: BorderRadius.circular(Sizes.p10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              Assets.images.allocationPagePinMap,
              width: Sizes.p18,
              height: Sizes.p20,
            ),
            const Text(ConstantsResourceDesign.atOffice,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Sizes.p12,
                  color: ColorResourceDesign.blackOne,
                )),
            ToolbarRectBtnWidget(
              btnText: ConstantsResourceDesign.yes,
              isBorder: false,
              onPressed: () {},
            ),
            ToolbarRectBtnWidget(
              onPressed: () {},
              btnText: ConstantsResourceDesign.no,
              isBorder: true,
              btnBackgroundColor: ColorResourceDesign.secondaryButtonBg,
              btnTextColor: ColorResourceDesign.secondaryButtonTextColor,
            ),
          ],
        ));
  }

  Widget _searchByPincode() {
    return Container(
        padding: const EdgeInsets.only(left: Sizes.p20),
        width: 400,
        height: 70,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: ColorResourceDesign.greyColor,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ConstantsResourceDesign.searchBasedOn,
                style: TextStyle(
                  fontWeight: FontResourceDesign.textFontWeightNormal,
                  fontSize: Sizes.p10,
                  color: ColorResourceDesign.blackTwo,
                )),
            Text(ConstantsResourceDesign.pincode,
                style: TextStyle(
                  fontWeight: FontResourceDesign.textFontWeightSemiBold,
                  fontSize: Sizes.p14,
                  color: ColorResourceDesign.blackTwo,
                ))
          ],
        ));
  }

  Widget _buttonList() {
    return Row(
      children: [
        ToolbarRectBtnWidget(
          onPressed: () {},
          btnText: ConstantsResourceDesign.priority,
          isBorder: false,
          btnWidth: 84,
          btnHeight: 30,
        ),
        gapW12,
        ToolbarRectBtnWidget(
          onPressed: () {},
          btnText: ConstantsResourceDesign.buildRoute,
          isBorder: true,
          btnWidth: 84,
          btnHeight: 30,
          btnBackgroundColor: ColorResourceDesign.secondaryButtonBg,
          btnTextColor: ColorResourceDesign.secondaryButtonTextColor,
        ),
        gapW12,
        ToolbarRectBtnWidget(
          onPressed: () {},
          btnText: ConstantsResourceDesign.mapView,
          isBorder: true,
          btnWidth: 84,
          btnHeight: 30,
          btnBackgroundColor: ColorResourceDesign.secondaryButtonBg,
          btnTextColor: ColorResourceDesign.secondaryButtonTextColor,
        ),
      ],
    );
  }
}

class PriorityCaseItemWidget extends StatefulWidget {
  const PriorityCaseItemWidget(this.item, this.index, {super.key});

  final PriorityCaseListModel item;
  final int index;

  @override
  State<PriorityCaseItemWidget> createState() => _PriorityCaseItemState();
}

class _PriorityCaseItemState extends State<PriorityCaseItemWidget> {
  @override
  Widget build(BuildContext context) {
    final int listCount = widget.index + 1;
    String? distanceValues;
    // if (resultData.length >= index && widget.item.distanceMeters != null) {
    //   distanceValues = widget.item.distanceMeters < 1000
    //       ? '${(widget.item.distanceMeters / 1000).toStringAsFixed(1)} Km'
    //       : '${(widget.item.distanceMeters / 1000).toStringAsFixed(2)} Km';
    // }
    final List<Address>? address = widget.item.address;
    List<String> maskedNumbers = [];
    // final ContractorResult? informationModel =
    //     Singleton.instance.contractorInformations?.result;
    // if (address != null) {
    //   for (Address item in address) {
    //     String value = item.value ?? '';
    //     if (item.cType!.contains('mobile') || item.cType!.contains('phone')) {
    //       if (informationModel?.cloudTelephony == true &&
    //           informationModel?.contactMasking == true &&
    //           address != null) {
    //         value = value.replaceRange(2, 7, 'XXXXX');
    //       }
    //       maskedNumbers.add(value);
    //     }
    //   }
    // }
    String? addressValue = '';
    if ("FIELDAGENT" == Constants.fieldagent) {
      if (widget.item.address?.isNotEmpty == true) {
        final addressList = widget.item.address;
        for (var item in addressList!) {
          final value = item.value ?? '';
          switch (item.cType) {
            case 'residence address':
              addressValue = value;
              break;
            case 'office address':
              addressValue = value;
              break;
            default:
              addressValue = value;
              break;
          }
          if (addressValue.isNotEmpty) {
            break;
          }
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visibility(
          //     visible: bloc.showFilterDistance,
          //     child: Padding(
          //       padding: const EdgeInsets.only(bottom: 7, top: 7),
          //       child: Container(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 3.0, vertical: 3.0),
          //           decoration: BoxDecoration(
          //             color: ColorResource.colorBEC4CF,
          //             borderRadius: BorderRadius.circular(75),
          //           ),
          //           child: Row(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               Container(
          //                 height: 26,
          //                 width: 26,
          //                 decoration: const BoxDecoration(
          //                   color: ColorResource.color23375A,
          //                   shape: BoxShape.circle,
          //                 ),
          //                 child: Center(
          //                     child: CustomText(
          //                   '$listCount',
          //                   lineHeight: 1,
          //                   fontSize: FontSize.twelve,
          //                   fontWeight: FontWeight.w700,
          //                   color: ColorResource.colorffffff,
          //                 )),
          //               ),
          //               const SizedBox(
          //                 width: 7,
          //               ),
          //               if (resultData.length >= index &&
          //                   widget.item.distanceMeters != null)
          //                 Column(
          //                   children: [
          //                     Padding(
          //                       padding: const EdgeInsets.only(right: 10),
          //                       child: CustomText(
          //                         widget.item.distanceMeters != null
          //                             ? Constants.approx +
          //                                 ' ' +
          //                                 distanceValues!
          //                             : '-',
          //                         lineHeight: 1,
          //                         color: ColorResource.color101010,
          //                       ),
          //                     ),
          //                     const SizedBox(
          //                       width: 10,
          //                     ),
          //                   ],
          //                 )
          //             ],
          //           )),
          //     )),
          if (widget.index == 0
              // && bloc.showFilterDistance == false
              )
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  CustomText(
                    // bloc.totalCases.toString() +
                    // resultData.length.toString() +
                    ' ' + LanguageEn().allocation,
                    color: ColorResourceDesign.color0066cc,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(
                    width: 9.0,
                  ),
                  SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(ImageResource.star)),
                  const SizedBox(
                    width: 5.0,
                  ),
                  CustomText(
                    // bloc.starCount.toString() +
                    //     ' ' +
                    LanguageEn().hignPriority,
                    fontSize: FontSize.ten,
                    color: ColorResourceDesign.color101010,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          Stack(
            children: [
              Padding(
                padding:
                    // bloc.showFilterDistance
                    // ? const EdgeInsets.only(bottom: 20)
                    // :
                    const EdgeInsets.only(bottom: 10, top: 19),
                child: InkWell(
                  onTap: () async {
                    // Singleton.instance.agrRef =
                    //     widget.item.agrRef ?? '';
                    // bloc.add(NavigateCaseDetailEvent(paramValues: {
                    //   'caseID': widget.item.caseId,
                    //   'isOffline': false
                    // }));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: ColorResourceDesign.colorffffff,
                      border: Border.all(
                          color: ColorResourceDesign.colorDADADA, width: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 2)
                              .copyWith(bottom: 0),
                          child: CustomText(
                            widget.item.agrRef!,
                            fontSize: FontSize.twelve,
                            color: ColorResourceDesign.color101010,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        AppUtils.showDivider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(23, 0, 10, 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      Constants.inr +
                                          widget.item.due.toString(),
                                      fontSize: FontSize.eighteen,
                                      color: ColorResourceDesign.color101010,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    const SizedBox(height: 3.0),
                                    CustomText(
                                      widget.item.cust!,
                                      fontSize: FontSize.sixteen,
                                      color: ColorResourceDesign.color101010,
                                    ),
                                  ],
                                ),
                              ),
                              if ("FIELDAGENT" == Constants.fieldagent)
                                widget.item.collSubStatus == 'new'
                                    ? CaseStatusWidget.satusTextWidget(
                                        context,
                                        text: LanguageEn().new_,
                                        width: 55,
                                      )
                                    : CaseStatusWidget.satusTextWidget(
                                        context,
                                        text: widget.item.collSubStatus ?? '',
                                      ),
                              if ("TELECALLE" == Constants.telecaller)
                                widget.item.telSubStatus == 'new'
                                    ? CaseStatusWidget.satusTextWidget(
                                        context,
                                        text: LanguageEn().new_,
                                        width: 55,
                                      )
                                    : CaseStatusWidget.satusTextWidget(
                                        context,
                                        text: widget.item.telSubStatus ?? '',
                                      ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: "FIELDAGENT" == Constants.fieldagent
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 5, 15, 5),
                                  decoration: BoxDecoration(
                                    color: ColorResourceDesign.colorF8F9FB,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        addressValue ?? '',
                                        color: ColorResourceDesign.color484848,
                                      ),
                                    ],
                                  ),
                                )
                              : Wrap(
                                  children: [
                                    for (var item in maskedNumbers)
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 8, right: 20),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 17, vertical: 6),
                                        decoration: BoxDecoration(
                                          color:
                                              ColorResourceDesign.colorF8F9FB,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: CustomText(
                                          item,
                                          color:
                                              ColorResourceDesign.color484848,
                                          lineHeight: 1.0,
                                        ),
                                      )
                                  ],
                                ),
                        ),
                        const SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: AppUtils.showDivider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(23, 0, 14, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                LanguageEn().followUpDate,
                                color: ColorResourceDesign.color101010,
                              ),
                              Row(
                                children: [
                                  if ("FIELDAGENT" == Constants.fieldagent)
                                    CustomText(
                                      widget.item.fieldfollowUpDate != null &&
                                              (widget.item.fieldfollowUpDate
                                                      ?.isNotEmpty ==
                                                  true)
                                          ? DateFormatUtils.followUpDateFormate(
                                              widget.item.fieldfollowUpDate!)
                                          : '-',
                                      color: ColorResourceDesign.color101010,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  if ("TELECALLER" == Constants.telecaller)
                                    CustomText(
                                      widget.item.followUpDate != null
                                          ? DateFormatUtils.followUpDateFormate(
                                              widget.item.followUpDate!)
                                          : '-',
                                      color: ColorResourceDesign.color101010,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      CustomText(
                                        LanguageEn().view,
                                        lineHeight: 1,
                                        color: ColorResourceDesign.color23375A,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SvgPicture.asset(
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
              // if (bloc.showFilterDistance == false)
              //   Container(
              //     alignment: Alignment.topRight,
              //     width: MediaQuery.of(context).size.width,
              //     padding: const EdgeInsets.symmetric(horizontal: 12),
              //     child: GestureDetector(
              //       onTap: () {
              //         // bloc.add(UpdateStaredCaseEvent(
              //         //     selectedStarIndex: index,
              //         //     caseID: widget.item.caseId!,
              //         //     context: context));
              //       },
              //       child: widget.item.starredCase
              //           ? SizedBox(
              //               height: 35,
              //               width: 35,
              //               child: SvgPicture.asset(ImageResource.star),
              //             )
              //           : SizedBox(
              //               height: 35,
              //               width: 35,
              //               child: SvgPicture.asset(ImageResource.unStar),
              //             ),
              //     ),
              //   ),
            ],
          ),
        ],
      ),
    );
  }
}
