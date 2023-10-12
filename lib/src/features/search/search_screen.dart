import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:design_system/fonts.dart';
import 'package:domain_models/common/searching_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:languages/app_languages.dart';
import 'package:origa/src/features/search/bloc/search_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_loading_widget.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoaded = false;

  late TextEditingController accountNoController = TextEditingController();
  late TextEditingController customerNameController = TextEditingController();
  late TextEditingController bankNameController = TextEditingController();
  late TextEditingController bucketController = TextEditingController();
  late TextEditingController statusController = TextEditingController();
  late TextEditingController pincodeController = TextEditingController();
  late TextEditingController customerIDController = TextEditingController();

  bool isMyRecentActivity = false;
  bool isStarOnly = false;
  late SearchingDataModel searchData;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchBloc>(context).add(SearchInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResourceDesign.grayThree,
      body: BlocListener<SearchBloc, SearchState>(
        bloc: BlocProvider.of<SearchBloc>(context),
        listener: (context, state) {
          if (state is NavigatePopState) {
            searchData = SearchingDataModel(
                accountNumber: accountNoController.text,
                customerID: customerIDController.text,
                customerName: customerNameController.text,
                bankName: bankNameController.text,
                dpdBucket: bucketController.text,
                pincode: pincodeController.text,
                status: statusController.text,
                isStarCases: isStarOnly,
                isMyRecentActivity: isMyRecentActivity);
            context.pop();
            context.push(context.namedLocation('searchList'),
                extra: searchData);
          }
        },
        child: BlocBuilder<SearchBloc, SearchState>(
          bloc: BlocProvider.of<SearchBloc>(context),
          builder: (context, state) {
            if (state is SearchLoadingState) {
              return const CustomLoadingWidget();
            }
            return Stack(
              children: [
                Column(
                  children: [
                    gapH28,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: Sizes.p20),
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
                                horizontal: Sizes.p20, vertical: Sizes.p10),
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
                                    gapH20,
                                    CustomTextField(
                                      Languages.of(context)!.customerName,
                                      customerNameController,
                                      isFill: true,
                                      isBorder: true,
                                    ),
                                    gapH20,
                                    CustomTextField(
                                      Languages.of(context)!.bankName,
                                      bankNameController,
                                      isFill: true,
                                      isBorder: true,
                                    ),
                                    gapH20,
                                    CustomTextField(
                                      Languages.of(context)!.dpdBucket,
                                      bucketController,
                                      isFill: true,
                                      isBorder: true,
                                    ),
                                    gapH20,
                                    CustomTextField(
                                      Languages.of(context)!.status,
                                      statusController,
                                      isFill: true,
                                      isBorder: true,
                                    ),
                                    gapH20,
                                    CustomTextField(
                                      Languages.of(context)!.pincode,
                                      pincodeController,
                                      isFill: true,
                                      isBorder: true,
                                      keyBoardType: TextInputType.number,
                                    ),
                                    gapH20,
                                    CustomTextField(
                                      Languages.of(context)!.customerID,
                                      customerIDController,
                                      isFill: true,
                                      isBorder: true,
                                    ),
                                    gapH20,
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
                                          gapW12,
                                          CustomText(
                                            Languages.of(context)!
                                                .myRecentActivity,
                                            color: ColorResourceDesign.blackTwo,
                                            fontSize: Sizes.p16,
                                            fontWeight: FontResourceDesign
                                                .textFontWeightNormal,
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
                                          gapW12,
                                          Flexible(
                                            child: CustomText(
                                              Languages.of(context)!
                                                  .showOnlyStar,
                                              color:
                                                  ColorResourceDesign.blackTwo,
                                              fontSize: Sizes.p16,
                                              fontWeight: FontResourceDesign
                                                  .textFontWeightNormal,
                                            ),
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
                isLoaded ? const CustomLoadingWidget() : const Stack()
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        color: ColorResourceDesign.whiteColor,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 85, vertical: Sizes.p12),
          child: CustomButton(
            Languages.of(context)!.search.toUpperCase(),
            fontSize: Sizes.p16,
            cardShape: 5,
            onTap: () {
              if (accountNoController.text.isNotEmpty ||
                  customerNameController.text.isNotEmpty ||
                  bankNameController.text.isNotEmpty ||
                  bucketController.text.isNotEmpty ||
                  statusController.text.isNotEmpty ||
                  pincodeController.text.isNotEmpty ||
                  customerIDController.text.isNotEmpty ||
                  isStarOnly ||
                  isMyRecentActivity) {
                BlocProvider.of<SearchBloc>(context).add(NavigatePopEvent());
              } else {
                AppUtils.showToast(
                  Languages.of(context)!.searchErrorMessage,
                  gravity: ToastGravity.CENTER,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
