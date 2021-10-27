// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/search_allocation_details_screen/bloc/search_allocation_details_bloc.dart';
import 'package:origa/utils/app_utils.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:origa/widgets/custom_textfield.dart';

class SearchAllocationDetailsScreen extends StatefulWidget {
  SearchAllocationDetailsScreen({Key? key}) : super(key: key);

  @override
  _SearchAllocationDetailsScreenState createState() =>
      _SearchAllocationDetailsScreenState();
}

class _SearchAllocationDetailsScreenState
    extends State<SearchAllocationDetailsScreen> {
  late SearchAllocationDetailsBloc bloc;

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
    bloc = SearchAllocationDetailsBloc()
      ..add(SearchAllocationDetailsInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorResource.colorC5C8CE,
        body: BlocListener<SearchAllocationDetailsBloc,
            SearchAllocationDetailsState>(
          bloc: bloc,
          listener: (context, state) {},
          child: BlocBuilder<SearchAllocationDetailsBloc,
              SearchAllocationDetailsState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is SearchAllocationDetailsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  CustomAppbar(
                    titleString: Languages.of(context)!.searchAllocationDetails,
                    titleSpacing: 21,
                    showClose: true,
                    onItemSelected: (value) {
                      if (value == 'close') {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
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
                                  ),
                                  const SizedBox(height: 19),
                                  CustomTextField(
                                    Languages.of(context)!.myRecentActivity,
                                    customerIDController,
                                    isFill: true,
                                    isBorder: true,
                                  ),
                                  const SizedBox(height: 19),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        value1 = !value1;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(value1
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
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        value2 = !value2;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(value2
                                            ? ImageResource.checkOn
                                            : ImageResource.checkOff),
                                        const SizedBox(width: 13),
                                        CustomText(
                                          Languages.of(context)!
                                              .showOnlyTopResults,
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
            padding: EdgeInsets.symmetric(horizontal: 85, vertical: 11.0),
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
                  AppUtils.showSnackBar(context,
                      StringResource.searchToastError.toUpperCase(), false);
                  // AppUtils.showToast('Please Enter Any One Field.',
                  //     gravity: ToastGravity.CENTER);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
