import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
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
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              childAspectRatio: 3 / 2.2,
                              maxCrossAxisExtent: 200,
                            ),
                            itemCount: bloc.dashboardList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomCard(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: ColorResource.colorFFFFFF, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(left: 11,right: 11,top: 7,bottom: 4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              height: 40,
                                              width: 100,
                                              child: CustomText(bloc
                                                  .dashboardList[index].title!,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
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
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(bloc
                                                  .dashboardList[index].image!),
                                            ),
                                          )
                                        ],
                                      ),
                                      CustomText(
                                        bloc.dashboardList[index].count!,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      CustomText(
                                          bloc.dashboardList[index].countNum!,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        bloc.dashboardList[index].amount!,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      CustomText(
                                          bloc.dashboardList[index].amountRs!,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ),
                              );

                            }),
                        SizedBox(height: 15),
                        CustomCard(
                          height: 55,
                          width: 320,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: ColorResource.colorFFFFFF, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                'YARDING & SELF- RELEASE',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorResource.color23375A
                                      .withOpacity(0.2),
                                ),
                                child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: Image.asset(ImageResource.vectorArrow),
                                ),
                              )
                            ],
                          ),
                        ),
                        CustomCard(
                          height: 55,
                          width: 320,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: ColorResource.colorFFFFFF, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                'FREQUENTLY ASKED QUESTIONS',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                width: 9,
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorResource.color23375A
                                      .withOpacity(0.2),
                                ),
                                child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: Image.asset(ImageResource.vectorArrow),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )));
            }));
  }
}
