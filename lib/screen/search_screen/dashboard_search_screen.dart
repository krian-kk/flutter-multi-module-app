import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';

class DashboardSearchScreen extends StatefulWidget {
  final DashboardBloc? bloc;
  const DashboardSearchScreen({Key? key, required this.bloc}) : super(key: key);
  @override
  _DashboardSearchScreenState createState() => _DashboardSearchScreenState();
}

class _DashboardSearchScreenState extends State<DashboardSearchScreen> {
  bool isLoaded = false;

  late TextEditingController accountNoController = TextEditingController();
  late TextEditingController customerNameController = TextEditingController();
  late TextEditingController bucketController = TextEditingController();
  late TextEditingController statusController = TextEditingController();
  late TextEditingController pincodeController = TextEditingController();
  late TextEditingController customerIDController = TextEditingController();

  bool isMyRecentActivity = false;
  bool isStarOnly = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.colorC5C8CE,
      body: BlocListener<DashboardBloc, DashboardState>(
        bloc: widget.bloc,
        listener: (context, state) {
          if (state is SearchDashboardScreenLoadedState) {
            setState(() {
              isLoaded = true;
            });
          }
          if (state is SearchDashboardScreenSuccessState) {
            setState(() => isLoaded = false);
            Navigator.pop(context);
          }
          if (state is SearchDashboardFailedState) {
            setState(() => isLoaded = false);
            AppUtils.showToast(state.error, gravity: ToastGravity.CENTER);
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
          bloc: widget.bloc,
          builder: (context, state) {
            if (state is SearchScreenLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: BottomSheetAppbar(
                        title: Languages.of(context)!.searchAllocationDetails,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    CustomTextField(
                                      Languages.of(context)!.accountNo + '.',
                                      accountNoController,
                                      isFill: true,
                                      isBorder: true,
                                    ),
                                    const SizedBox(height: 19),
                                    CustomTextField(
                                      Languages.of(context)!.customerName,
                                      customerNameController,
                                      isFill: true,
                                      isBorder: true,
                                    ),
                                    const SizedBox(height: 19),
                                    CustomTextField(
                                      Languages.of(context)!.dpdBucket,
                                      bucketController,
                                      isFill: true,
                                      isBorder: true,
                                    ),
                                    const SizedBox(height: 19),
                                    CustomTextField(
                                      Languages.of(context)!.status,
                                      statusController,
                                      isFill: true,
                                      isBorder: true,
                                    ),
                                    const SizedBox(height: 19),
                                    CustomTextField(
                                      Languages.of(context)!.pincode,
                                      pincodeController,
                                      isFill: true,
                                      isBorder: true,
                                      keyBoardType: TextInputType.number,
                                    ),
                                    const SizedBox(height: 19),
                                    CustomTextField(
                                      Languages.of(context)!.customerID,
                                      customerIDController,
                                      isFill: true,
                                      isBorder: true,
                                    ),
                                    const SizedBox(height: 19),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isMyRecentActivity =
                                              !isMyRecentActivity;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(isMyRecentActivity
                                              ? ImageResource.checkOn
                                              : ImageResource.checkOff),
                                          const SizedBox(width: 13),
                                          CustomText(
                                            Languages.of(context)!
                                                .myRecentActivity,
                                            color: ColorResource.color000000,
                                            fontSize: FontSize.sixteen,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isStarOnly = !isStarOnly;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(isStarOnly
                                              ? ImageResource.checkOn
                                              : ImageResource.checkOff),
                                          const SizedBox(width: 13),
                                          CustomText(
                                            Languages.of(context)!.showOnlyStar,
                                            color: ColorResource.color000000,
                                            fontSize: FontSize.sixteen,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                isLoaded
                    ? const Center(child: CircularProgressIndicator())
                    : Stack()
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        color: ColorResource.colorFFFFFF,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
          child: CustomButton(
            Languages.of(context)!.search.toUpperCase(),
            fontSize: FontSize.sixteen,
            fontWeight: FontWeight.w600,
            cardShape: 5,
            onTap: () {
              if (accountNoController.text.isNotEmpty ||
                  customerNameController.text.isNotEmpty ||
                  bucketController.text.isNotEmpty ||
                  statusController.text.isNotEmpty ||
                  pincodeController.text.isNotEmpty ||
                  customerIDController.text.isNotEmpty) {
                widget.bloc!.add(ClickDashboardSearchButtonEvent(
                    isStarOnly, 'MOR000800314934'));
              } else {
                // AppUtils.showSnackBar(context,
                //     Languages.of(context)!.searchErrorMessage, true);
                AppUtils.showToast(Languages.of(context)!.searchErrorMessage,
                    gravity: ToastGravity.CENTER);
              }
            },
          ),
        ),
      ),
    );
  }
}
