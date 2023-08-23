import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:design_system/strings.dart';
import 'package:design_system/widgets/customLabel_widget.dart';
import 'package:design_system/widgets/toolbarRectBtn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:origa/src/features/allocation/bloc/allocation_bloc.dart';
import 'package:origa/src/features/search/bloc/search_bloc.dart';
import 'package:origa/src/features/search/search_list/bloc/search_list_bloc.dart';
import 'package:repository/search_list_repository.dart';
import '../../../../gen/assets.gen.dart';

class AllocationView extends StatefulWidget {
  const AllocationView({Key? key}) : super(key: key);

  @override
  State<AllocationView> createState() => _AllocationViewState();
}

class _AllocationViewState extends State<AllocationView> {

  String? searchBasedOnValue;

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<AllocationBloc>(context).add(AllocationInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AllocationBloc, AllocationState>(
      bloc: BlocProvider.of<AllocationBloc>(context),
      listener: (BuildContext context, AllocationState state) {
        if (state is NavigateSearchPageState) {
          context.push(context.namedLocation('search'));
          // if (returnValue != null) {
          //   BlocProvider.of<AllocationBloc>(context)
          //       .add(SearchReturnDataEvent(returnValue: returnValue));
          //   final data = returnValue as SearchingDataModel;
          //   if (data.isStarCases!) {
          //     searchBasedOnValue = 'Stared Cases (High Priority)';
          //   } else if (data.isMyRecentActivity!) {
          //     searchBasedOnValue = 'My Recent Activity';
          //   } else if (data.accountNumber!.isNotEmpty) {
          //     searchBasedOnValue = 'Account Number: ' + data.accountNumber!;
          //   } else if (data.customerName!.isNotEmpty) {
          //     searchBasedOnValue = 'Customer Name: ' + data.customerName!;
          //   } else if (data.bankName!.isNotEmpty) {
          //     searchBasedOnValue = 'Bank Name : ' + data.bankName!;
          //   } else if (data.dpdBucket!.isNotEmpty) {
          //     searchBasedOnValue = 'DPD/Bucket: ' + data.dpdBucket!;
          //   } else if (data.status!.isNotEmpty) {
          //     searchBasedOnValue = 'Status: ' + data.status!;
          //   } else if (data.pincode!.isNotEmpty) {
          //     searchBasedOnValue = 'Pincode: ' + data.pincode!;
          //   } else if (data.customerID!.isNotEmpty) {
          //     searchBasedOnValue = 'Customer ID: ' + data.customerID!;
          //   }
          // }
        }
      },
      child: BlocProvider(
        create: (BuildContext context) => SearchBloc(),
        child: Scaffold(
            backgroundColor: ColorResourceDesign.primaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  gapH8,
                  _officeChecker(),
                  gapH12,
                  _searchByPincode(),
                  gapH16,
                  _buttonList(),
                  gapH16,
                  _allocationBloc(),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorResourceDesign.blackOne,
              tooltip: ConstantsResourceDesign.search,
              // used by assistive technologies
              onPressed: () async {
                BlocProvider.of<AllocationBloc>(context)
                    .add(NavigateSearchPageEvent());
                // Navigator.of(context).push(
                // MaterialPageRoute(builder: (context) => const SearchScreen())),
              },

              child: const Icon(
                Icons.search,
                size: Sizes.p30,
              ),
            )),
      ),
    );
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

  Widget _allocationBloc() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Sizes.p10),
          child: Row(
            children: [
              const Text(ConstantsResourceDesign.allocationNo,
                  style: TextStyle(
                    fontSize: Sizes.p14,
                    fontWeight: FontResourceDesign.textFontWeightSemiBold,
                    color: ColorResourceDesign.blackTwo,
                  )),
              gapW8,
              Container(
                decoration: const BoxDecoration(
                  color: ColorResourceDesign.starActiveBg,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: SvgPicture.asset(
                    Assets.images.allocationPageHighPriorityActive),
              ),
              gapW4,
              const Text(ConstantsResourceDesign.noHighPriority,
                  style: TextStyle(
                    fontSize: Sizes.p10,
                    fontWeight: FontResourceDesign.textFontWeightSemiBold,
                    color: ColorResourceDesign.appTextPrimaryColor,
                  )),
            ],
          ),
        ),
        gapH8,
        Container(
          width: 400,
          // height:220,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(Sizes.p10)),
              color: ColorResourceDesign.whiteColor,
              border: Border.all(
                width: 0.5,
                color: ColorResourceDesign.borderColor,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: Sizes.p8, left: Sizes.p24),
                child: Text(ConstantsResourceDesign.tvs,
                    style: TextStyle(
                      fontSize: Sizes.p12,
                      fontWeight: FontResourceDesign.textFontWeightLight,
                      color: ColorResourceDesign.appTextPrimaryColor,
                    )),
              ),
              const Divider(
                thickness: 0.5,
                color: Color(0xFFDADADA),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: Sizes.p24, right: Sizes.p24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹ 3,97,553.67',
                          style: TextStyle(
                            fontSize: Sizes.p18,
                            fontWeight:
                            FontResourceDesign.textFontWeightSemiBold,
                            color: ColorResourceDesign.appTextPrimaryColor,
                          ),
                        ),
                        CustomLabelWidget(
                          labelText: ConstantsResourceDesign.newLabel,
                        ),
                      ],
                    ),
                    const Text('Debashish Patnaik',
                        style: TextStyle(
                          fontWeight: FontResourceDesign.textFontWeightLight,
                          fontSize: Sizes.p16,
                          color: ColorResourceDesign.appTextPrimaryColor,
                        )),
                    gapH8,
                    Container(
                        width: 290,
                        height: 72,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: ColorResourceDesign.primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('2/345, 6th Main Road Gomathipuram,',
                                style: TextStyle(
                                  fontWeight:
                                  FontResourceDesign.textFontWeightLight,
                                  fontSize: Sizes.p14,
                                  color: ColorResourceDesign.darkGray,
                                )),
                            Text('Madurai - 625032',
                                style: TextStyle(
                                  fontWeight:
                                  FontResourceDesign.textFontWeightLight,
                                  fontSize: Sizes.p14,
                                  color: ColorResourceDesign.darkGray,
                                ))
                          ],
                        )),
                    const Divider(
                      thickness: 0.5,
                      color: ColorResourceDesign.lightGray,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Follow Up Date',
                            style: TextStyle(
                              fontWeight:
                              FontResourceDesign.textFontWeightLight,
                              fontSize: Sizes.p14,
                              color: ColorResourceDesign.darkGray,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Today, Thu 18 Oct, 2021',
                                style: TextStyle(
                                  fontWeight:
                                  FontResourceDesign.textFontWeightLight,
                                  fontSize: Sizes.p14,
                                  color: ColorResourceDesign.darkGray,
                                )),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Text('View',
                                    style: TextStyle(
                                      fontWeight: FontResourceDesign
                                          .textFontWeightSemiBold,
                                      fontSize: Sizes.p14,
                                      color: ColorResourceDesign.blueColor,
                                    )),
                                gapW8,
                                SvgPicture.asset(
                                    Assets.images.allocationPageRightTick)
                              ],
                            ),
                          ],
                        ),
                        gapH16,
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
