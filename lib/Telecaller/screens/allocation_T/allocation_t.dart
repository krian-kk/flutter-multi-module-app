import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/Telecaller/screens/allocation_T/auto_calling.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/router.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/floating_action_button.dart';

import 'bloc/allocation_t_bloc.dart';
import 'custom_card_list.dart';

class AllocationTelecallerScreen extends StatefulWidget {
  const AllocationTelecallerScreen({Key? key}) : super(key: key);


  @override
  _AllocationTelecallerScreenState createState() => _AllocationTelecallerScreenState();
}

class _AllocationTelecallerScreenState extends State<AllocationTelecallerScreen> {
  late AllocationTBloc bloc;
  String version = "";

  @override
  void initState() {
    super.initState();
    bloc = AllocationTBloc()..add(AllocationTInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocListener<AllocationTBloc, AllocationTState>(
      bloc: bloc,
      listener: (BuildContext context, AllocationTState state) {
        if (state is NavigateSearchPageTState) {
           Navigator.pushNamed(
                          context, AppRoutes.searchAllocationDetailsScreen);
        }
      },
      child: BlocBuilder<AllocationTBloc, AllocationTState>(
        bloc: bloc,
        builder: (BuildContext context, AllocationTState state) {
          if (state is AllocationTLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            backgroundColor: ColorResource.colorF7F8FA,
            floatingActionButton: Visibility(
              visible: bloc.isEnableSearchButton,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomFloatingActionButton(
                  onTap: () async {
                    bloc.add(NavigateSearchPageTEvent());
                  },
                ),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Wrap(
                          runSpacing: 0,
                          spacing: 10,
                          children: _buildFilterOptions(),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      // bloc.showFilterDistance
                      //     ? _buildBuildRoute()
                      //     : SizedBox(),
                      // Expanded(child: WidgetUtils.buildListView(bloc)),
                    ],
                  ),
                ),
                if (bloc.selectedOption == 0)
                 Expanded(child: CustomCardList.buildListView(bloc)),
                if (bloc.selectedOption == 1)
                Expanded(child: SingleChildScrollView(child: AutoCalling.buildAutoCalling(context, bloc))),
              ],
            ),
            bottomNavigationBar: Visibility(
              visible: bloc.isEnableStartCallButton,
              child: Container(
                  height: 88,
                  decoration: const BoxDecoration(
                    color: ColorResource.colorffffff,
                      border: Border(
                          top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.13)))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 5, 20, 18),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: CustomButton(
                            Languages.of(context)!.stop.toUpperCase(),
                            fontSize: FontSize.sixteen,
                            textColor: ColorResource.colorEA6D48,
                            fontWeight: FontWeight.w600,
                            cardShape: 5,
                            buttonBackgroundColor: ColorResource.colorffffff,
                            borderColor: ColorResource.colorffffff,
                            onTap: () {
                              // Navigator.pop(context);
                            },
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: CustomButton(
                            Languages.of(context)!.startCalling.toUpperCase(),
                            fontSize: FontSize.sixteen,
                            fontWeight: FontWeight.w600,
                            cardShape: 5,
                            trailingWidget: Image.asset(ImageResource.vector),
                            isLeading: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
        print(element);
        print(index);
        setState(() {
          bloc.selectedOption = index;
        });
        if (index == 0) {
          bloc.isEnableSearchButton = true;
          bloc.isEnableStartCallButton = false;
        } 
        if (index == 1) {
          bloc.isEnableSearchButton = false;
          bloc.isEnableStartCallButton = true;
        } 
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

}
