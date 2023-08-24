import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:design_system/strings.dart';
import 'package:design_system/widgets/customLabel_widget.dart';
import 'package:design_system/widgets/toolbarRectBtn_widget.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:origa/gen/assets.gen.dart';
import 'package:origa/src/features/allocation/presentation/priority_list_view/priority_bloc.dart';
import 'package:repository/case_repository.dart';
import 'package:repository/repo_utils.dart';

class AllocationView extends StatefulWidget {
  const AllocationView({Key? key}) : super(key: key);

  @override
  State<AllocationView> createState() => _AllocationViewState();
}

class _AllocationViewState extends State<AllocationView> {
  static const _pageSize = 20;
  final _pagingController =
      PagingController<int, PriorityCaseListModel>(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      String access = await getAccessToken();

      final apiResult = await BlocProvider.of<PriorityBloc>(context)
          .repository
          .collectApiProvider
          .getCases(access, _pageSize, pageKey);
      List<PriorityCaseListModel> newItems = [];
      apiResult.when(
          success: (value) => {newItems = value ?? []},
          failure: (failure) => {});
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey.toInt());
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: PagedListView<int, PriorityCaseListModel>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<PriorityCaseListModel>(
              itemBuilder: (context, item, index) => _allocationBloc(),
            ))
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
        );
  }

  Widget _officeChecker() {
    return Container(
        width: 400,
        height: 50,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(
            color: whiteGray,
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
            const Text(atOffice,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Sizes.p12,
                  color: blackOne,
                )),
            ToolbarRectBtnWidget(
              btnText: yes,
              isBorder: false,
              onPressed: () {},
            ),
            ToolbarRectBtnWidget(
              onPressed: () {},
              btnText: no,
              isBorder: true,
              btnBackgroundColor: secondaryButtonBg,
              btnTextColor: secondaryButtonTextColor,
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
          color: greyColor,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(searchBasedOn,
                style: TextStyle(
                  fontWeight: textFontWeightNormal,
                  fontSize: Sizes.p10,
                  color: blackTwo,
                )),
            Text(pincode,
                style: TextStyle(
                  fontWeight: textFontWeightSemiBold,
                  fontSize: Sizes.p14,
                  color: blackTwo,
                ))
          ],
        ));
  }

  Widget _buttonList() {
    return Row(
      children: [
        ToolbarRectBtnWidget(
          onPressed: () {},
          btnText: priority,
          isBorder: false,
          btnWidth: 84,
          btnHeight: 30,
        ),
        gapW12,
        ToolbarRectBtnWidget(
          onPressed: () {},
          btnText: buildRoute,
          isBorder: true,
          btnWidth: 84,
          btnHeight: 30,
          btnBackgroundColor: secondaryButtonBg,
          btnTextColor: secondaryButtonTextColor,
        ),
        gapW12,
        ToolbarRectBtnWidget(
          onPressed: () {},
          btnText: mapView,
          isBorder: true,
          btnWidth: 84,
          btnHeight: 30,
          btnBackgroundColor: secondaryButtonBg,
          btnTextColor: secondaryButtonTextColor,
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
              const Text(allocationNo,
                  style: TextStyle(
                    fontSize: Sizes.p14,
                    fontWeight: textFontWeightSemiBold,
                    color: blackTwo,
                  )),
              gapW8,
              Container(
                decoration: const BoxDecoration(
                  color: starActiveBg,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: SvgPicture.asset(
                    Assets.images.allocationPageHighPriorityActive),
              ),
              gapW4,
              const Text(noHighPriority,
                  style: TextStyle(
                    fontSize: Sizes.p10,
                    fontWeight: textFontWeightSemiBold,
                    color: appTextPrimaryColor,
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
              color: whiteColor,
              border: Border.all(
                width: 0.5,
                color: borderColor,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: Sizes.p8, left: Sizes.p24),
                child: Text(tvs,
                    style: TextStyle(
                      fontSize: Sizes.p12,
                      fontWeight: textFontWeightLight,
                      color: appTextPrimaryColor,
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
                            fontWeight: textFontWeightSemiBold,
                            color: appTextPrimaryColor,
                          ),
                        ),
                        CustomLabelWidget(
                          labelText: newLabel,
                        ),
                      ],
                    ),
                    const Text('Debashish Patnaik',
                        style: TextStyle(
                          fontWeight: textFontWeightLight,
                          fontSize: Sizes.p16,
                          color: appTextPrimaryColor,
                        )),
                    gapH8,
                    Container(
                        width: 290,
                        height: 72,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('2/345, 6th Main Road Gomathipuram,',
                                style: TextStyle(
                                  fontWeight: textFontWeightLight,
                                  fontSize: Sizes.p14,
                                  color: darkGray,
                                )),
                            Text('Madurai - 625032',
                                style: TextStyle(
                                  fontWeight: textFontWeightLight,
                                  fontSize: Sizes.p14,
                                  color: darkGray,
                                ))
                          ],
                        )),
                    const Divider(
                      thickness: 0.5,
                      color: lightGray,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Follow Up Date',
                            style: TextStyle(
                              fontWeight: textFontWeightLight,
                              fontSize: Sizes.p14,
                              color: darkGray,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Today, Thu 18 Oct, 2021',
                                style: TextStyle(
                                  fontWeight: textFontWeightLight,
                                  fontSize: Sizes.p14,
                                  color: darkGray,
                                )),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Text('View',
                                    style: TextStyle(
                                      fontWeight: textFontWeightSemiBold,
                                      fontSize: Sizes.p14,
                                      color: blueColor,
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
