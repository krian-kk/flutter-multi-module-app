import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/priority_case_list.dart';
import 'package:origa/models/search_model/search_model.dart';
import 'package:origa/router.dart';
import 'package:origa/screen/allocation/map_view.dart';
import 'package:origa/screen/map_screen/bloc/map_bloc.dart';
import 'package:origa/screen/map_screen/bloc/map_event.dart';
import 'package:origa/screen/map_screen/map_screen.dart';
import 'package:origa/screen/message_screen/message.dart';
import 'package:origa/screen/search_screen/search_screen.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/floating_action_button.dart';
import 'package:origa/widgets/widget_utils.dart';

import 'bloc/allocation_bloc.dart';
import 'custom_card_list.dart';

class AllocationScreen extends StatefulWidget {
  // AuthenticationBloc authenticationBloc;
  // AllocationScreen(this.authenticationBloc);

  @override
  _AllocationScreenState createState() => _AllocationScreenState();
}

class _AllocationScreenState extends State<AllocationScreen> {
  late AllocationBloc bloc;
  late MapBloc mapBloc;
  bool areyouatOffice = true;
  String version = "";
  List<Result> resultList = [];
  @override
  void initState() {
    super.initState();
    bloc = AllocationBloc()..add(AllocationInitialEvent());
    // mapBloc = MapBloc()..add(MapInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocListener<AllocationBloc, AllocationState>(
      bloc: bloc,
      listener: (BuildContext context, AllocationState state) {
        if (state is MapViewState) {
          mapView(context);
        }
        if (state is MessageState) {
          messageShowBottomSheet();
        }
        if (state is FilterSelectOptionState) {}

        if (state is NavigateCaseDetailState) {
          Navigator.pushNamed(context, AppRoutes.caseDetailsScreen,
              arguments: true);
        }
        if (state is NavigateSearchPageState) {
          searchShowBottomSheet();
          // var result = Navigator.pushNamed(context, AppRoutes.SearchScreen,
          //     arguments: bloc);
        }
        if (state is AllocationLoadedState) {
          //List<Result>
          if (state.successResponse is List<Result>) {
            resultList = state.successResponse;
          }
        }
      },
      child: BlocBuilder<AllocationBloc, AllocationState>(
        bloc: bloc,
        builder: (BuildContext context, AllocationState state) {
          if (state is AllocationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: ColorResource.colorF7F8FA,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                      width: 175,
                      // padding: EdgeInsets.all(10),
                      child: CustomButton(
                        Languages.of(context)!.message,
                        alignment: MainAxisAlignment.end,
                        cardShape: 50,
                        isTrailing: true,
                        leadingWidget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 40,
                            child: Container(
                              height: 26,
                              width: 26,
                              // ignore: prefer_const_constructors
                              decoration: BoxDecoration(
                                color: ColorResource.colorFFFFFF,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: CustomText(
                                '2',
                                color: ColorResource.colorEA6D48,
                                fontSize: FontSize.twelve,
                                fontWeight: FontWeight.w700,
                                lineHeight: 1,
                              )),
                            ),
                          ),
                        ),
                        onTap: () {
                          bloc.add(MessageEvent());
                          AppUtils.showToast('Message');
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  CustomFloatingActionButton(
                    onTap: () async {
                      bloc.add(NavigateSearchPageEvent());
                    },
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: areyouatOffice,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: ColorResource.colorffffff,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: ColorResource.colorECECEC, width: 1.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(ImageResource.location),
                              const SizedBox(
                                width: 13.0,
                              ),
                              CustomText(
                                Languages.of(context)!.areYouAtOffice,
                                fontSize: FontSize.twelve,
                                fontWeight: FontWeight.w700,
                                color: ColorResource.color000000,
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              SizedBox(
                                  width: 80,
                                  height: 40,
                                  child: CustomButton(
                                    Languages.of(context)!.yes,
                                    fontSize: FontSize.twelve,
                                    borderColor: ColorResource.colorEA6D48,
                                    buttonBackgroundColor:
                                        ColorResource.colorEA6D48,
                                    cardShape: 5,
                                    onTap: () {
                                      setState(() {
                                        areyouatOffice = false;
                                      });
                                    },
                                  )),
                              const SizedBox(
                                width: 6.0,
                              ),
                              Container(
                                  width: 80,
                                  height: 40,
                                  child: CustomButton(
                                    Languages.of(context)!.no,
                                    fontSize: FontSize.twelve,
                                    textColor: ColorResource.color23375A,
                                    buttonBackgroundColor:
                                        ColorResource.colorffffff,
                                    cardShape: 5,
                                    onTap: () {
                                      setState(() {
                                        areyouatOffice = false;
                                      });
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Visibility(
                        visible: bloc.isShowSearchPincode,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(35, 55, 90, 0.27),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                Languages.of(context)!.searchbasedOn,
                                fontSize: FontSize.ten,
                                color: ColorResource.color000000,
                                fontWeight: FontWeight.w600,
                              ),
                              // const SizedBox(height: 10.0,),
                              CustomText(
                                Languages.of(context)!.pincode + ' 636808',
                                fontSize: FontSize.fourteen,
                                color: ColorResource.color000000,
                                fontWeight: FontWeight.w700,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 15.0,
                      // ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Wrap(
                          runSpacing: 0,
                          spacing: 10,
                          children: _buildFilterOptions(),
                        ),
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),
                      bloc.showFilterDistance
                          ? _buildBuildRoute()
                          : const SizedBox(),
                      // const SizedBox(
                      //   height: 5.0,
                      // ),
                      // Expanded(child: WidgetUtils.buildListView(bloc)),
                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 0.0),
                  child: CustomCardList.buildListView(bloc,
                      resultData: resultList),
                )),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildFilterOptions() {
    List<Widget> widgets = [];
    bloc.selectOptions.asMap().forEach((index, element) {
      widgets.add(_buildFilterWidget(index, element));
    });
    return widgets;
  }

  Widget _buildFilterWidget(int index, String element) {
    return InkWell(
      onTap: () {
        setState(() {
          bloc.selectedOption = index;
        });
        switch (index) {
          case 0:
            setState(() {
              bloc.showFilterDistance = false;
            });
            break;
          case 1:
            setState(() {
              bloc.showFilterDistance = true;
            });
            break;
          case 2:
            bloc.add(MapViewEvent());
            setState(() {
              bloc.showFilterDistance = false;
            });
            break;
          default:
            setState(() {
              bloc.showFilterDistance = false;
            });
        }
        // if (option == 'Build Route') {
        //   setState(() {
        //     bloc.showFilterDistance = true;
        //   });
        // } else {
        //   setState(() {
        //     bloc.showFilterDistance = false;
        //   });
        // }
        // print(option);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
        width: 90,
        // height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: ColorResource.color23375A, width: 0.5),
          borderRadius: BorderRadius.circular(5),
          color: index == bloc.selectedOption
              ? ColorResource.color23375A
              : Colors.white,
        ),
        child: Center(
          child: CustomText(
            element,
            fontSize: FontSize.twelve,
            fontWeight: FontWeight.w700,
            color: index == bloc.selectedOption
                ? Colors.white
                : ColorResource.color000000,
          ),
        ),
      ),
    );
  }

  Widget _buildBuildRoute() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 7,
        ),
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
                'No.1, ABC Street, Gandhi Nagar 1st phase',
                fontSize: FontSize.twelve,
                fontWeight: FontWeight.w700,
                color: ColorResource.color101010,
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
                  color: ColorResource.color23375A,
                ),
                onTap: () {
                  AppUtils.showToast('Change address');
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
    );
  }

  List<Widget> _buildRouteFilterOptions() {
    List<Widget> widgets = [];
    bloc.filterBuildRoute.forEach((element) {
      widgets.add(_buildRouteFilterWidget(element));
    });
    return widgets;
  }

  Widget _buildRouteFilterWidget(String distance) {
    return InkWell(
      onTap: () {
        setState(() {
          bloc.selectedDistance = distance;
        });
        print(distance);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
        width: 93,
        // height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: ColorResource.color23375A, width: 0.5),
          borderRadius: BorderRadius.circular(85),
          color: distance == bloc.selectedDistance
              ? ColorResource.color23375A
              : Colors.white,
        ),
        child: Center(
          child: CustomText(
            distance,
            fontSize: FontSize.twelve,
            fontWeight: FontWeight.w700,
            color: distance == bloc.selectedDistance
                ? Colors.white
                : ColorResource.color000000,
          ),
        ),
      ),
    );
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
        backgroundColor: ColorResource.colorFFFFFF,
        builder: (BuildContext context) {
          return MapView(bloc);
        });
  }

  messageShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.86,
                    child: MessageChatRoomScreen())));
  }

  searchShowBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: ColorResource.colorFFFFFF,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) => StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) =>
                SizedBox(
                    height: MediaQuery.of(context).size.height * 1.0,
                    child: SearchScreen(bloc: bloc))));
  }
}
