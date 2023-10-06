import 'dart:io';
import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:design_system/strings.dart';
import 'package:design_system/widgets/custom_button.dart';
import 'package:domain_models/common/buildroute_data.dart';
import 'package:domain_models/response_models/case/priority_case_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:languages/app_languages.dart';
import 'package:languages/language_english.dart';
import 'package:origa/screen/map_view_bottom_sheet_screen/map.dart';
import 'package:origa/src/common_widgets/toolbar_rect_btn_widget.dart';
import 'package:origa/src/features/allocation/bloc/allocation_bloc.dart';
import 'package:origa/src/features/allocation/presentation/build_route_list_view/build_route_bloc.dart';
import 'package:origa/src/features/allocation/presentation/priority_list_view/priority_bloc.dart';
import 'package:origa/src/routing/app_router.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/constants.dart';
import 'package:origa/utils/date_format_utils.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/skeleton.dart';
import 'package:origa/widgets/case_status_widget.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:repository/allocation_repository.dart';
import 'package:workmanager/workmanager.dart';

class AllocationView extends StatefulWidget {
  const AllocationView({Key? key}) : super(key: key);

  @override
  State<AllocationView> createState() => _AllocationViewState();
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (kDebugMode) {
      AppUtils.showToast('Work manager triggered ');
      print('Native called background task: $task');
    }
    if (await Permission.location.isGranted) {
      final Position result = await Geolocator.getCurrentPosition();
      await AllocationRepositoryImpl()
          .putCurrentLocation(result.latitude, result.longitude);
    }
    return Future.value(true);
  });
}

class _AllocationViewState extends State<AllocationView> {
  final PagingController<int, PriorityCaseListModel> _pagingController =
      PagingController(firstPageKey: 1);

  bool isPageLoading = true;
  List<String> filterOptions = <String>[];

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllocationBloc>(context).add(AllocationInitialEvent());

    BlocProvider.of<PriorityBloc>(context).add(LoadPriorityList(1));
    _pagingController.addPageRequestListener((pageKey) {
      if (BlocProvider.of<AllocationBloc>(context).tab == 1) {
        String dist = Constants.allDisMeters;
        if (BlocProvider.of<AllocationBloc>(context).buildRouteSubTab == 1) {
          dist = Constants.maxDisMeters;
        } else if (BlocProvider.of<AllocationBloc>(context).buildRouteSubTab ==
            2) {
          dist = Constants.minDisMeters;
        } else {
          dist = Constants.allDisMeters;
        }
        BlocProvider.of<BuildRouteBloc>(context).add(LoadBuildRouteCases(
            paramValues: BuildRouteDataModel(
                lat: BlocProvider.of<AllocationBloc>(context)
                    .position
                    .latitude
                    .toString(),
                long: BlocProvider.of<AllocationBloc>(context)
                    .position
                    .longitude
                    .toString(),
                maxDistMeters: dist),
            pageKey: BlocProvider.of<AllocationBloc>(context).pageKey));
      } else {
        BlocProvider.of<PriorityBloc>(context).add(LoadPriorityList(pageKey));
      }
      BlocProvider.of<AllocationBloc>(context).pageKey = pageKey;
    });
  }

  Future<void> locationTracker() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    if (Platform.isAndroid) {
      if (kDebugMode) {
        AppUtils.showToast('Platform.isAndroid');
      }
      await Workmanager().registerPeriodicTask(
        'uniqueNameIdentifier',
        'uniqueNamePeriodicTask',
        constraints: Constraints(
            networkType: NetworkType.connected,
            requiresBatteryNotLow: true,
            requiresCharging: true,
            requiresDeviceIdle: true,
            requiresStorageNotLow: true),
        initialDelay: const Duration(seconds: 5),
        frequency: const Duration(minutes: 15),
      );
    } else {
      if (kDebugMode) {
        AppUtils.showToast('Platform.isIOS');
      }
      await Workmanager().registerPeriodicTask(
        'uniqueNameIdentifier',
        'uniqueNamePeriodicTask',
        frequency: const Duration(minutes: 15),
        initialDelay: const Duration(seconds: 5),
        constraints: Constraints(
            networkType: NetworkType.connected,
            requiresBatteryNotLow: true,
            requiresCharging: true,
            requiresDeviceIdle: true,
            requiresStorageNotLow: true),
      );
    }
  }

  mapView(BuildContext buildContext) {
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        context: buildContext,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        backgroundColor: ColorResourceDesign.colorFFFFFF,
        builder: (BuildContext context) {
          return MapNavigation(
              multipleLatLong: BlocProvider.of<AllocationBloc>(buildContext)
                  .multipleLatLong);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<AllocationBloc, AllocationState>(
            bloc: BlocProvider.of<AllocationBloc>(context),
            listener: (BuildContext context, AllocationState state) async {
              if (state is AllocationLoadedState) {
                if (BlocProvider.of<AllocationBloc>(context).userType ==
                    Constants.fieldagent) {
                  if (BlocProvider.of<AllocationBloc>(context)
                          .isGoogleApiKeyNull ==
                      true) {
                    filterOptions = [
                      Languages.of(context)!.priority,
                    ];
                  } else {
                    filterOptions = [
                      Languages.of(context)!.priority,
                      Languages.of(context)!.buildRoute,
                      Languages.of(context)!.mapView,
                    ];
                    BlocProvider.of<AllocationBloc>(context)
                        .add(InitialCurrentLocationEvent());
                  }
                }

                if (BlocProvider.of<AllocationBloc>(context).userType ==
                    Constants.telecaller) {
                  if (BlocProvider.of<AllocationBloc>(context)
                          .isCloudTelephony ==
                      false) {
                    filterOptions = [
                      Languages.of(context)!.priority,
                    ];
                  } else {
                    filterOptions = [
                      Languages.of(context)!.priority,
                      Languages.of(context)!.autoCalling,
                    ];
                  }
                }
                BlocProvider.of<AllocationBloc>(context).areYouAtOffice = false;
              }
              if (state is UpdatedCurrentLocationState) {
                await locationTracker();
              }

              if (state is TapAreYouAtOfficeOptionsSuccessState) {
                AppUtils.showToast(
                    Languages.of(context)!.successfullySubmitted);
              }

              if (state is MapViewState) {
                mapView(context);
              }

              if (state is NavigateSearchPageState) {
                context.push(context.namedLocation('search'));
              }
            },
          ),
          BlocListener<PriorityBloc, PriorityState>(
            listener: (context, state) {
              if (state is PriorityLoadingState) {
                isPageLoading = true;
              }
              if (state is PriorityCompletedState) {
                BlocProvider.of<AllocationBloc>(context).add(
                    AllocationTabLoadedEvent(
                        tabLoaded: Languages.of(context)!.priority));
                if (BlocProvider.of<AllocationBloc>(context).isRefresh) {
                  _pagingController.itemList?.clear();
                }
                if (state.nextPageKey == null) {
                  _pagingController.appendLastPage(state.listItems);
                } else {
                  _pagingController.appendPage(
                      state.listItems, state.nextPageKey);
                }
                isPageLoading = false;
                BlocProvider.of<AllocationBloc>(context).isRefresh = false;
              }
            },
          ),
          BlocListener<BuildRouteBloc, BuildRouteState>(
            listener: (context, state) {
              if (state is BuildRouteLoadingState) {
                isPageLoading = true;
              }

              if (state is BuildRouteCasesCompletedState) {
                isPageLoading = false;
                BlocProvider.of<AllocationBloc>(context).add(
                    AllocationTabLoadedEvent(
                        tabLoaded: Languages.of(context)!.buildRoute));
                if (BlocProvider.of<AllocationBloc>(context).isRefresh) {
                  _pagingController.itemList?.clear();
                }
                if (state.nextPageKey == null) {
                  _pagingController.appendLastPage(state.listItems);
                } else {
                  _pagingController.appendPage(
                      state.listItems, state.nextPageKey);
                }
                BlocProvider.of<AllocationBloc>(context).isRefresh = false;
              }
            },
          ),
        ],
        child: BlocBuilder<AllocationBloc, AllocationState>(
          builder: (context, state) {
            return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.only(left: Sizes.p10),
                  child: Column(
                    children: [
                      Visibility(
                        visible: BlocProvider.of<AllocationBloc>(context)
                            .areYouAtOffice,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: ColorResourceDesign.colorffffff,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorResourceDesign.colorECECEC),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImageResource.location),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: CustomText(
                                        Languages.of(context)!.areYouAtOffice,
                                        fontSize: FontSize.twelve,
                                        fontWeight: FontWeight.w700,
                                        color: ColorResourceDesign.color000000,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: BlocProvider.of<AllocationBloc>(context)
                                        .isSubmitRUOffice
                                    ? const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: CustomLoadingWidget(
                                            radius: 14,
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                              width: Languages.of(context)!
                                                          .no
                                                          .length ==
                                                      2
                                                  ? 75
                                                  : 64,
                                              height: 40,
                                              child: CustomButton(
                                                Languages.of(context)!.yes,
                                                fontSize: FontSize.twelve,
                                                cardShape: 5,
                                                borderColor: ColorResourceDesign
                                                    .color23375A,
                                                buttonBackgroundColor:
                                                    ColorResourceDesign
                                                        .color23375A,
                                                isRemoveExtraPadding: true,
                                                onTap: () {
                                                  BlocProvider.of<
                                                              AllocationBloc>(
                                                          context)
                                                      .add(
                                                          TapAreYouAtOfficeOptionsEvent());
                                                },
                                              )),
                                          Languages.of(context)!.no.length == 2
                                              ? SizedBox(
                                                  width: 74,
                                                  height: 40,
                                                  child: CustomButton(
                                                    Languages.of(context)!.no,
                                                    fontSize: FontSize.twelve,
                                                    borderColor:
                                                        ColorResourceDesign
                                                            .color23375A,
                                                    textColor:
                                                        ColorResourceDesign
                                                            .color23375A,
                                                    buttonBackgroundColor:
                                                        ColorResourceDesign
                                                            .colorffffff,
                                                    cardShape: 5,
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  AllocationBloc>(
                                                              context)
                                                          .add(
                                                              TapAreYouAtOfficeOptionsEvent());
                                                    },
                                                  ))
                                              : Expanded(
                                                  child: SizedBox(
                                                      height: 40,
                                                      child: CustomButton(
                                                        Languages.of(context)!
                                                            .no,
                                                        fontSize:
                                                            FontSize.twelve,
                                                        borderColor:
                                                            ColorResourceDesign
                                                                .color23375A,
                                                        textColor:
                                                            ColorResourceDesign
                                                                .color23375A,
                                                        buttonBackgroundColor:
                                                            ColorResourceDesign
                                                                .colorffffff,
                                                        cardShape: 5,
                                                        onTap: () {
                                                          BlocProvider.of<
                                                                      AllocationBloc>(
                                                                  context)
                                                              .add(
                                                                  TapAreYouAtOfficeOptionsEvent());
                                                        },
                                                      )),
                                                ),
                                        ],
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                      gapH12,
                      Row(children: [
                        ToolbarRectBtnWidget(
                          onPressed: () {
                            BlocProvider.of<AllocationBloc>(context)
                                .add(AllocationTabClicked(tab: 0));
                            BlocProvider.of<PriorityBloc>(context)
                                .add(LoadPriorityList(1));
                          },
                          btnBackgroundColor:
                              BlocProvider.of<AllocationBloc>(context).tab == 0
                                  ? ColorResourceDesign.primaryButtonBg
                                  : ColorResourceDesign.secondaryButtonBg,
                          btnTextColor:
                              BlocProvider.of<AllocationBloc>(context).tab == 0
                                  ? ColorResourceDesign.appTextSecondaryColor
                                  : ColorResourceDesign.appTextPrimaryColor,
                          btnText: Languages.of(context)!.priority,
                          isBorder: false,
                          btnWidth: 84,
                          btnHeight: 30,
                        ),
                        gapW12,
                        BlocProvider.of<AllocationBloc>(context).userType ==
                                Constants.fieldagent
                            ? ToolbarRectBtnWidget(
                                onPressed: () {
                                  BlocProvider.of<AllocationBloc>(context)
                                      .add(AllocationTabClicked(tab: 1));

                                  BlocProvider.of<BuildRouteBloc>(context).add(
                                      LoadBuildRouteCases(
                                          paramValues: BuildRouteDataModel(
                                              lat: BlocProvider.of<
                                                      AllocationBloc>(context)
                                                  .position
                                                  .latitude
                                                  .toString(),
                                              long: BlocProvider.of<
                                                      AllocationBloc>(context)
                                                  .position
                                                  .longitude
                                                  .toString(),
                                              maxDistMeters:
                                                  Constants.allDisMeters),
                                          pageKey: 1));
                                },
                                btnText: Languages.of(context)!.buildRoute,
                                isBorder: true,
                                btnWidth: 84,
                                btnHeight: 30,
                                btnBackgroundColor:
                                    BlocProvider.of<AllocationBloc>(context)
                                                .tab ==
                                            1
                                        ? ColorResourceDesign.primaryButtonBg
                                        : ColorResourceDesign.secondaryButtonBg,
                                btnTextColor: BlocProvider.of<AllocationBloc>(
                                                context)
                                            .tab ==
                                        1
                                    ? ColorResourceDesign.appTextSecondaryColor
                                    : ColorResourceDesign.appTextPrimaryColor,
                              )
                            : ToolbarRectBtnWidget(
                                onPressed: () {},
                                btnBackgroundColor:
                                    BlocProvider.of<AllocationBloc>(context)
                                                .tab ==
                                            1
                                        ? ColorResourceDesign.primaryButtonBg
                                        : ColorResourceDesign.secondaryButtonBg,
                                btnTextColor: BlocProvider.of<AllocationBloc>(
                                                context)
                                            .tab ==
                                        1
                                    ? ColorResourceDesign.appTextSecondaryColor
                                    : ColorResourceDesign.appTextPrimaryColor,
                                btnText: Languages.of(context)!.autoCalling,
                                isBorder: false,
                                btnWidth: 84,
                                btnHeight: 30,
                              ),
                        gapW12,
                        BlocProvider.of<AllocationBloc>(context).userType ==
                                Constants.fieldagent
                            ? ToolbarRectBtnWidget(
                                onPressed: () {
                                  BlocProvider.of<AllocationBloc>(context).add(
                                      MapViewEvent(
                                          paramValues: BuildRouteDataModel(
                                              lat:
                                                  BlocProvider.of<
                                                              AllocationBloc>(
                                                          context)
                                                      .position
                                                      .latitude
                                                      .toString(),
                                              long: BlocProvider.of<
                                                      AllocationBloc>(context)
                                                  .position
                                                  .longitude
                                                  .toString(),
                                              maxDistMeters:
                                                  Constants.allDisMeters),
                                          pageKey:
                                              BlocProvider.of<AllocationBloc>(
                                                      context)
                                                  .pageKey));
                                },
                                btnText: Languages.of(context)!.mapView,
                                isBorder: true,
                                btnWidth: 84,
                                btnHeight: 30,
                                btnBackgroundColor:
                                    ColorResourceDesign.secondaryButtonBg,
                                btnTextColor:
                                    ColorResourceDesign.appTextPrimaryColor,
                              )
                            : const SizedBox(),
                      ]),
                      isPageLoading
                          ? const Expanded(child: SkeletonLoading())
                          : BlocBuilder<AllocationBloc, AllocationState>(
                              builder: (BuildContext context, state) {
                                if (state is AllocationTabLoadedState) {
                                  if (state.loadedTab ==
                                      Languages.of(context)!.priority) {
                                    return Expanded(
                                      child: PagedListView<int,
                                              PriorityCaseListModel>(
                                          pagingController: _pagingController,
                                          builderDelegate:
                                              PagedChildBuilderDelegate<
                                                  PriorityCaseListModel>(
                                            itemBuilder:
                                                (context, item, index) =>
                                                    PriorityCaseItemWidget(
                                                        item, index),
                                          )),
                                    );
                                  } else if (state.loadedTab ==
                                      Languages.of(context)!.buildRoute) {
                                    return Expanded(
                                      child: PagedListView<int,
                                              PriorityCaseListModel>(
                                          pagingController: _pagingController,
                                          builderDelegate:
                                              PagedChildBuilderDelegate<
                                                  PriorityCaseListModel>(
                                            itemBuilder:
                                                (context, item, index) =>
                                                    BuildRouteCaseItemWidget(
                                                        item, index),
                                          )),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                } else if (state is MapViewLoadingState) {
                                  return const CustomLoadingWidget();
                                } else {
                                  return BlocProvider.of<AllocationBloc>(
                                                  context)
                                              .tab ==
                                          0
                                      ? Expanded(
                                          child: PagedListView<int,
                                                  PriorityCaseListModel>(
                                              pagingController:
                                                  _pagingController,
                                              builderDelegate:
                                                  PagedChildBuilderDelegate<
                                                      PriorityCaseListModel>(
                                                itemBuilder:
                                                    (context, item, index) =>
                                                        PriorityCaseItemWidget(
                                                            item, index),
                                              )),
                                        )
                                      : Expanded(
                                          child: PagedListView<int,
                                                  PriorityCaseListModel>(
                                              pagingController:
                                                  _pagingController,
                                              builderDelegate:
                                                  PagedChildBuilderDelegate<
                                                      PriorityCaseListModel>(
                                                itemBuilder: (context, item,
                                                        index) =>
                                                    BuildRouteCaseItemWidget(
                                                        item, index),
                                              )),
                                        );
                                }
                              },
                            ),
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
                  },
                  child: const Icon(
                    Icons.search,
                    size: Sizes.p30,
                  ),
                ));
          },
        ));
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
    //todo move to repository

    final int listCount = widget.index + 1;
    String? distanceValues;
    // if (resultData.length >= index && widget.item.distanceMeters != null) {
    //   distanceValues = widget.item.distanceMeters < 1000
    //       ? '${(widget.item.distanceMeters / 1000).toStringAsFixed(1)} Km'
    //       : '${(widget.item.distanceMeters / 1000).toStringAsFixed(2)} Km';
    // }
    final List<Address>? address = widget.item.address;
    //todo move to repository
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
    //todo move to repository

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
          CaseItemStackWidget(item: widget.item),
        ],
      ),
    );
  }
}

class CaseItemStackWidget extends StatelessWidget {
  final PriorityCaseListModel item;

  CaseItemStackWidget({super.key, required this.item});

  List<String> maskedNumbers = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 2)
                            .copyWith(bottom: 0),
                    child: CustomText(
                      item.agrRef!,
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
                                Constants.inr + item.due.toString(),
                                fontSize: FontSize.eighteen,
                                color: ColorResourceDesign.color101010,
                                fontWeight: FontWeight.w700,
                              ),
                              const SizedBox(height: 3.0),
                              CustomText(
                                item.cust!,
                                fontSize: FontSize.sixteen,
                                color: ColorResourceDesign.color101010,
                              ),
                            ],
                          ),
                        ),
                        if ("FIELDAGENT" == Constants.fieldagent)
                          item.collSubStatus == 'new'
                              ? CaseStatusWidget.satusTextWidget(
                                  context,
                                  text: LanguageEn().new_,
                                  width: 55,
                                )
                              : CaseStatusWidget.satusTextWidget(
                                  context,
                                  text: item.collSubStatus ?? '',
                                ),
                        if ("TELECALLE" == Constants.telecaller)
                          item.telSubStatus == 'new'
                              ? CaseStatusWidget.satusTextWidget(
                                  context,
                                  text: LanguageEn().new_,
                                  width: 55,
                                )
                              : CaseStatusWidget.satusTextWidget(
                                  context,
                                  text: item.telSubStatus ?? '',
                                ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: "FIELDAGENT" == Constants.fieldagent
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(20, 5, 15, 5),
                            decoration: BoxDecoration(
                              color: ColorResourceDesign.colorF8F9FB,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // CustomText(
                                //   addressValue ?? '',
                                //   color: ColorResourceDesign.color484848,
                                // ),
                              ],
                            ),
                          )
                        : Wrap(
                            children: [
                              for (var item in maskedNumbers)
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 8, right: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: ColorResourceDesign.colorF8F9FB,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: CustomText(
                                    item,
                                    color: ColorResourceDesign.color484848,
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
                                item.fieldfollowUpDate != null &&
                                        (item.fieldfollowUpDate?.isNotEmpty ==
                                            true)
                                    ? DateFormatUtils.followUpDateFormate(
                                        item.fieldfollowUpDate!)
                                    : '-',
                                color: ColorResourceDesign.color101010,
                                fontWeight: FontWeight.w700,
                              ),
                            if ("TELECALLER" == Constants.telecaller)
                              CustomText(
                                item.followUpDate != null
                                    ? DateFormatUtils.followUpDateFormate(
                                        item.followUpDate!)
                                    : '-',
                                color: ColorResourceDesign.color101010,
                                fontWeight: FontWeight.w700,
                              ),
                            const Spacer(),
                            GestureDetector(
                                    onTap: _openCaseDetails,
                                    child: Row(
                                      children: [
                                        CustomText(
                                          LanguageEn().view,
                                          lineHeight: 1,
                                          color:
                                              ColorResourceDesign.color23375A,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SvgPicture.asset(
                                            ImageResource.forwardArrow)
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
    );
  }
}

class BuildRouteCaseItemWidget extends StatefulWidget {
  const BuildRouteCaseItemWidget(this.item, this.index, {super.key});

  final PriorityCaseListModel item;
  final int index;

  @override
  State<BuildRouteCaseItemWidget> createState() =>
      _BuildRouteCaseItemWidgetState();
}

class _BuildRouteCaseItemWidgetState extends State<BuildRouteCaseItemWidget> {
  List<String> maskedNumbers = [];

  List<Widget> _buildRouteFilterOptions() {
    final List<Widget> widgets = [];
    BlocProvider.of<AllocationBloc>(context)
        .filterBuildRoute
        .asMap()
        .forEach((index, element) {
      widgets.add(BuildRouteFilterOptionsWidget(index, element));
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.index == 0
              // && bloc.showFilterDistance == false
              )
            Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(ImageResource.location2),
                    const SizedBox(
                      width: 8,
                    ),
                    const SizedBox(
                      width: 213,
                      child: CustomText(
                        'currentAddress',
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                        fontSize: FontSize.twelve,
                        fontWeight: FontWeight.w700,
                        color: ColorResourceDesign.color101010,
                        isSingleLine: true,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: GestureDetector(
                        child: CustomText(
                          Languages.of(context)!.change,
                          fontSize: FontSize.twelve,
                          fontWeight: FontWeight.w700,
                          color: ColorResourceDesign.color23375A,
                        ),
                        onTap: () {
                          // getCurrentLocation();
                          // AppUtils.showToast('Change address');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  children: _buildRouteFilterOptions(),
                ),
                const SizedBox(
                  height: 7,
                ),
              ],
            ),
          CaseItemStackWidget(item: widget.item),
        ],
      ),
    );
  }
}

class BuildRouteFilterOptionsWidget extends StatefulWidget {
  const BuildRouteFilterOptionsWidget(this.index, this.distance, {super.key});

  final int index;
  final String distance;

  @override
  State<BuildRouteFilterOptionsWidget> createState() =>
      _BuildRouteFilterOptionsWidgetState();
}

class _BuildRouteFilterOptionsWidgetState
    extends State<BuildRouteFilterOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    String? maxDistance;
    return InkWell(
      onTap: () {
        switch (widget.index) {
          case 0:
            maxDistance = Constants.allDisMeters;
            break;
          case 1:
            maxDistance = Constants.minDisMeters;
            break;
          case 2:
            maxDistance = Constants.maxDisMeters;
            break;
          default:
        }
        BlocProvider.of<AllocationBloc>(context).buildRouteSubTab =
            widget.index;
        BlocProvider.of<AllocationBloc>(context)
            .add(BuildRouteFilterClickedEvent(widget.index));
        BlocProvider.of<BuildRouteBloc>(context).add(BuildRouteFilterClicked(
          selectedDistance: widget.distance,
          paramValues: BuildRouteDataModel(
              lat: BlocProvider.of<AllocationBloc>(context)
                  .position
                  .latitude
                  .toString(),
              long: BlocProvider.of<AllocationBloc>(context)
                  .position
                  .longitude
                  .toString(),
              maxDistMeters: maxDistance),
          pageKey: BlocProvider.of<AllocationBloc>(context).pageKey,
        ));
      },
      child: BlocBuilder<AllocationBloc, AllocationState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
            width: 96,
            // height: 35,
            decoration: BoxDecoration(
              border: Border.all(
                  color: ColorResourceDesign.primaryButtonBg, width: 0.5),
              borderRadius: BorderRadius.circular(85),
              color:
                  BlocProvider.of<AllocationBloc>(context).buildRouteSubTab ==
                          widget.index
                      ? ColorResourceDesign.primaryButtonBg
                      : ColorResourceDesign.secondaryButtonBg,
            ),
            child: Center(
              child: CustomText(
                widget.distance,
                fontSize: FontSize.twelve,
                fontWeight: FontWeight.w700,
                color:
                    BlocProvider.of<AllocationBloc>(context).buildRouteSubTab ==
                            widget.index
                        ? ColorResourceDesign.appTextSecondaryColor
                        : ColorResourceDesign.appTextPrimaryColor,
              ),
            ),
          );
        },
      ),
    );
  }

  void _openCaseDetails() {
    context.go('/${AppRouter.caseDetailsScreen}',
        extra: {'caseID': widget.item.caseId, 'isOffline': false});
  }
}
