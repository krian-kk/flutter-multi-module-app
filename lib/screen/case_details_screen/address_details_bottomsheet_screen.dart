// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/case_details_screen/address_screen/address_screen.dart';
import 'package:origa/screen/case_details_screen/bloc/case_details_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_loan_user_details.dart';
import 'package:origa/widgets/custom_text.dart';

class AddressDetailsBottomSheetScreen extends StatefulWidget {
  const AddressDetailsBottomSheetScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final CaseDetailsBloc bloc;

  @override
  State<AddressDetailsBottomSheetScreen> createState() =>
      _AddressDetailsBottomSheetScreenState();
}

class _AddressDetailsBottomSheetScreenState
    extends State<AddressDetailsBottomSheetScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.89,
      child: Column(
        children: [
          BottomSheetAppbar(
            title: Languages.of(context)!.addressDetails.toUpperCase(),
            padding: EdgeInsets.fromLTRB(21, 13, 21, 12),
            color: ColorResource.color23375A,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(21, 0, 21, 12),
            child: CustomLoanUserDetails(
              userName:
                  widget.bloc.caseDetailsResult.result?.caseDetails?.cust ?? '',
              userId:
                  widget.bloc.caseDetailsResult.result?.caseDetails?.accNo ??
                      '',
              userAmount: widget.bloc.caseDetailsResult.result?.caseDetails?.due
                      ?.toDouble() ??
                  0,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 13)
                        .copyWith(top: 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     CustomText(
                    //       Languages.of(context)!.addressDetails.toUpperCase(),
                    //       fontSize: FontSize.fourteen,
                    //       fontWeight: FontWeight.w700,
                    //       fontStyle: FontStyle.normal,
                    //       color: ColorResource.color23375A,
                    //     ),
                    //     Spacer(),
                    //     GestureDetector(
                    //         onTap: () {
                    //           Navigator.pop(context);
                    //         },
                    //         child: Image.asset(ImageResource.close))
                    //   ],
                    // ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.bloc.caseDetailsResult.result!
                          .addressDetails!.length,
                      itemBuilder: (context, i) {
                        return SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                (i + 1 > 9)
                                    ? Languages.of(context)!
                                            .address
                                            .toUpperCase() +
                                        '${i + 1}'
                                    : Languages.of(context)!
                                            .address
                                            .toUpperCase() +
                                        '0'
                                            '${i + 1}',
                                fontWeight: FontWeight.w700,
                                fontSize: FontSize.fourteen,
                                color: ColorResource.color23375A,
                                fontStyle: FontStyle.normal,
                              ),
                              SizedBox(height: 7),
                              Container(
                                width: double.infinity,
                                decoration: new BoxDecoration(
                                    color: ColorResource.colorF8F9FB,
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(10.0))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 12, 12, 12),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: CustomText(
                                              widget
                                                  .bloc
                                                  .caseDetailsResult
                                                  .result!
                                                  .addressDetails![i]['value']
                                                  .toString()
                                                  .toUpperCase(),
                                              fontSize: FontSize.fourteen,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal,
                                              color: ColorResource.color484848,
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 10),
                                                  Image.asset(ImageResource
                                                      .activePerson),
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              child: Container(
                                                  decoration: new BoxDecoration(
                                                      color: ColorResource
                                                          .colorBEC4CF,
                                                      borderRadius:
                                                          new BorderRadius.all(
                                                              new Radius
                                                                      .circular(
                                                                  75.0))),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(ImageResource
                                                          .direction),
                                                      SizedBox(width: 12),
                                                      CustomText(
                                                        Languages.of(context)!
                                                            .viewMap,
                                                        fontSize:
                                                            FontSize.fourteen,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ColorResource
                                                            .color23375A,
                                                      ),
                                                      SizedBox(width: 12),
                                                    ],
                                                  ))),
                                          Spacer(),
                                          SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.pushNamed(
                                              //     context, AppRoutes.addressScreen);
                                              Navigator.pop(context);
                                              addressBottomSheet(
                                                  context, widget.bloc);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  Languages.of(context)!.view,
                                                  lineHeight: 1,
                                                  color:
                                                      ColorResource.color23375A,
                                                  fontSize: FontSize.fourteen,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                const SizedBox(width: 10),
                                                Image.asset(
                                                    ImageResource.viewShape,
                                                    height: 20),
                                                SizedBox(width: 5)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 15)
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void addressBottomSheet(BuildContext buildContext, CaseDetailsBloc bloc) {
  showCupertinoModalPopup(
      context: buildContext,
      builder: (BuildContext context) {
        return SafeArea(
          // top: false,
          bottom: false,
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.89,
              child: AddressScreen(bloc: bloc)),
          // child: Container(
          //   width: double.infinity,
          //   height: 300,
          //   color: ColorResource.colorFFFFFF,
          // )
        );
      });
}

// Route _createRoute() {
//   return PageRouteBuilder(
//     transitionDuration: Duration(microseconds: 3),
//     pageBuilder: (context, animation, secondaryAnimation) => AddressScreen(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       final tween = Tween(begin: begin, end: end);
//       final offsetAnimation = animation.drive(tween);
//       return SlideTransition(
//         position: offsetAnimation,
//         child: child,
//       );
//     },
//   );
// }
