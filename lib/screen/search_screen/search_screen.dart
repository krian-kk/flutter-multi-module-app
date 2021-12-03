import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/searching_data_model.dart';
import 'package:origa/screen/search_screen/bloc/search_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoaded = false;
  late SearchScreenBloc bloc;

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
    bloc = SearchScreenBloc()..add(SearchScreenInitialEvent());
    print('[-------Search------]');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.colorC5C8CE,
      body: BlocListener<SearchScreenBloc, SearchScreenState>(
        bloc: bloc,
        listener: (context, state) {
          // TODO: implement listener
          if(state is NavigatePopState){
            Navigator.pop(context, 
            SearchingDataModel(accountNumber: accountNoController.text,customerID: customerIDController.text,
            customerName: customerNameController.text,dpdBucket: bucketController.text,
            pincode: pincodeController.text,status: statusController.text, isStarCases: isStarOnly, isMyRecentActivity: isMyRecentActivity));
          }
        },
        child: BlocBuilder<SearchScreenBloc, SearchScreenState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is SearchScreenLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return 
           Stack(
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
                        // onTap: (){
                        //   bloc.add(NavigatePopEvent());
                        // },
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
                                        print(isMyRecentActivity);
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
                                        print(isStarOnly);
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
                  customerIDController.text.isNotEmpty || isStarOnly || isMyRecentActivity) {
                bloc.add(NavigatePopEvent());
              } else {
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
