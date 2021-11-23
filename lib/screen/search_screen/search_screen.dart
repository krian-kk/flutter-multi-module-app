import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/allocation/bloc/allocation_bloc.dart';
import 'package:origa/screen/search_screen/bloc/search_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {
  late SearchScreenBloc bloc;

  late TextEditingController accountNoController = TextEditingController();
  late TextEditingController customerNameController = TextEditingController();
  late TextEditingController bucketController = TextEditingController();
  late TextEditingController statusController = TextEditingController();
  late TextEditingController pincodeController = TextEditingController();
  late TextEditingController customerIDController = TextEditingController();

  bool value1 = false;
  bool value2 = false;

  @override
  void initState() {
    super.initState();
    bloc = SearchScreenBloc()
      ..add(SearchScreenInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.colorC5C8CE,
      body: BlocListener<SearchScreenBloc,
          SearchScreenState>(
        bloc: bloc,
        listener: (context, state) {
          // if (state is ShowPincodeInAllocationState) {

          // }
        },
        child: BlocBuilder<SearchScreenBloc,
            SearchScreenState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is SearchScreenLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: BottomSheetAppbar(title: Languages.of(context)!.searchAllocationDetails,),
                ),
                // CustomAppbar(
                //   titleString: Languages.of(context)!.searchAllocationDetails,
                //   titleSpacing: 21,
                //   showClose: true,
                //   onItemSelected: (value) {
                //     if (value == 'close') {
                //       Navigator.pop(context);
                //     }
                //   },
                // ),
                Expanded(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                                      value1 = !value1;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(value1
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
                                      value2 = !value2;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(value2
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
                Navigator.pop(context);
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
