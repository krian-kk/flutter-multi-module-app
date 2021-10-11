import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/dashboard/broken_ptp.dart';
import 'package:origa/screen/dashboard/my_visits.dart';
import 'package:origa/screen/dashboard/priority_follow_up_bottomsheet.dart';
import 'package:origa/screen/dashboard/untouched_cases.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_card_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String version = "";
  late DashboardBloc bloc;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    bloc = DashboardBloc()..add(DashboardInitialEvent());
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return BlocListener<DashboardBloc, DashboardState>(
        bloc: bloc,
        listener: (BuildContext context, DashboardState state) {
          // TODO: implement listener
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
            bloc: bloc,
            builder: (BuildContext context, DashboardState state) {
              return Scaffold(
                  backgroundColor: ColorResource.colorF7F8FA,
                  body: SafeArea(
                    bottom: false,
                      child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          StaggeredGridView.countBuilder(
                            physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 4,
                              // gridDelegate:
                              //     const SliverGridDelegateWithMaxCrossAxisExtent(
                              //   childAspectRatio: 3 / 2.49,
                              //   maxCrossAxisExtent: 200,
                              // ),
                              itemCount: bloc.dashboardList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      switch (bloc.dashboardList[index].title) {
                                        case 'PRIORITY FOLLOW UP':
                                          priorityFollowUpSheet(context);
                                          break;
                                        case 'BROKEN PTP':
                                          brokenPTPSheet(context);
                                          break;
                                        case 'UNTOUCHED CASES':
                                          untouchedCasesSheet(context);
                                          break;
                                        case 'MY VISITS':
                                          myVisitsSheet(context);
                                          break;
                                        default:
                                        AppUtils.showToast('select other');
                                      }
                                     
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(color: ColorResource.colorFFFFFF, width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(12, 7, 10, 8),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              // height: 50,
                                              // color: ColorResource.color484848,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      // height: 40,
                                                      width: 105,
                                                      // color: ColorResource.color101010,
                                                      child: CustomText(bloc
                                                          .dashboardList[index].title!,
                                                        fontSize: FontSize.twelve,
                                                        fontWeight: FontWeight.w700,
                                                        color: ColorResource.color101010,
                                                      )),
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: ColorResource.color23375A
                                                          .withOpacity(0.2),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(9.0),
                                                      child: Image.asset(bloc
                                                          .dashboardList[index].image!),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            // const SizedBox(height: 4,),
                                            const Spacer(),
                                            if (bloc.dashboardList[index].count! != '')
                                            CustomText(
                                              bloc.dashboardList[index].count!,
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            if (bloc.dashboardList[index].countNum! != '')
                                            CustomText(
                                                bloc.dashboardList[index].countNum!,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            if (bloc.dashboardList[index].amount! != '')
                                            CustomText(
                                              bloc.dashboardList[index].amount!,
                                              fontSize: 10,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            if (bloc.dashboardList[index].amountRs! != '')
                                            CustomText(
                                                bloc.dashboardList[index].amountRs!,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                              },
                               staggeredTileBuilder: (int index) =>
                                     StaggeredTile.count(2, index == 5 ? 1 : index == 6 ? 0.7 : 1.7),
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                              ),
                          // const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: CustomButton(
                              'YARDING & SELF- RELEASE',
                            fontSize: FontSize.twelve,
                            fontWeight: FontWeight.w700,
                            textColor: ColorResource.color101010,
                            buttonBackgroundColor: ColorResource.colorffffff,
                            borderColor: ColorResource.colorffffff,
                            cardElevation: 3,
                            isTrailing: true,
                            onTap: (){
                              
                            },
                            leadingWidget: Row(
                              children: [
                                const SizedBox(width: 7,),
                                Container(
                                        height: 32,
                                        width: 32,
                                       decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                       color: ColorResource.color23375A
                                             .withOpacity(0.2),
                                           ),
                                         child: Padding(
                                         padding: const EdgeInsets.all(9.0),
                                         child: Image.asset(ImageResource.vectorArrow),
                                           ),
                                        ),
                              ],
                            ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: CustomButton('FREQUENTLY ASKED QUESTIONS',
                            fontSize: FontSize.twelve,
                            fontWeight: FontWeight.w700,
                            textColor: ColorResource.color101010,
                            buttonBackgroundColor: ColorResource.colorffffff,
                            borderColor: ColorResource.colorffffff,
                            cardElevation: 3,
                            isTrailing: true,
                            leadingWidget: Row(
                              children: [
                                const SizedBox(width: 7,),
                                Container(
                                        height: 32,
                                        width: 32,
                                       decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                       color: ColorResource.color23375A
                                             .withOpacity(0.2),
                                           ),
                                         child: Padding(
                                         padding: const EdgeInsets.all(9.0),
                                         child: Image.asset(ImageResource.vectorArrow),
                                           ),
                                        ),
                              ],
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )));
            }));
  }

  void priorityFollowUpSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
            // top: false,
            bottom: false,
            child: PriorityFollowUpBottomSheet(bloc));
        });
  }

   void brokenPTPSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
            // top: false,
            bottom: false,
            child: BrokenPTPBottomSheet(bloc));
        });
  }

   void untouchedCasesSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
            // top: false,
            bottom: false,
            child: UntouchedCasesBottomSheet(bloc));
        });
  }

 void myVisitsSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        context: buildContext,
        builder: (BuildContext context) {
          return SafeArea(
            // top: false,
            bottom: false,
            child: MyVisitsBottomSheet(bloc));
        });
  }
}
