import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/dashboard/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';

import '../../router.dart';

class CashResults extends StatefulWidget {
  final DashboardBloc bloc;
  CashResults(this.bloc, {Key? key}) : super(key: key);

  @override
  _CashResultsState createState() => _CashResultsState();
}

class _CashResultsState extends State<CashResults> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
     builder: (BuildContext context, StateSetter setState) {
       return Scaffold(
         body: Column(
           // ignore: prefer_const_literals_to_create_immutables
           children: [
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(5.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Expanded(
                             flex: 2,
                             child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 CustomText(
                                 Languages.of(context)!.count,
                                 fontSize: FontSize.ten,
                                 color: ColorResource.color101010,),
                                 CustomText('200', 
                                 fontSize: FontSize.fourteen,
                                 color: ColorResource.color101010,
                                 fontWeight: FontWeight.w700,
                                 ),
                               ],
                             ),
                           ),
                           Expanded(
                             flex: 7,
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 CustomText(
                                 Languages.of(context)!.amount,
                                 fontSize: FontSize.ten,
                                 color: ColorResource.color101010,),
                                 CustomText('₹ 3,97,553.67', 
                                 fontSize: FontSize.fourteen,
                                 color: ColorResource.color101010,
                                 fontWeight: FontWeight.w700,
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                     Expanded(
                       child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.bloc.caseList.length,
        itemBuilder: (BuildContext context, int index) {
        int listCount = index +1;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorResource.colorffffff,
                    border:
                        Border.all(color: ColorResource.colorDADADA, width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        // spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 2.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                            child: CustomText(
                              Languages.of(context)!.loanAccountNumber,
                              fontSize: FontSize.twelve,
                              color: ColorResource.color101010,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                            child: CustomText(
                                  widget.bloc.caseList[index].loanID!,
                                  fontSize: FontSize.fourteen,
                                  color: ColorResource.color101010,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                      Divider(
                        color: ColorResource.colorDADADA,
                        thickness: 0.5,
                      ),
                      // const SizedBox(height: 6.0,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(23, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              widget.bloc.caseList[index].amount!,
                              fontSize: FontSize.eighteen,
                              color: ColorResource.color101010,
                              fontWeight: FontWeight.w700,
                            ),
                            const SizedBox(
                              height: 3.0,
                            ),
                            CustomText(
                              widget.bloc.caseList[index].customerName!,
                              fontSize: FontSize.sixteen,
                              color: ColorResource.color101010,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 12, 15, 12),
                          decoration: BoxDecoration(
                            color: ColorResource.colorF8F9FB,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomText(
                            widget.bloc.caseList[index].address!,
                            color: ColorResource.color484848,
                            fontSize: FontSize.fourteen,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Divider(
                          color: ColorResource.colorDADADA,
                          thickness: 0.5,
                        ),
                      ),
                      //  const SizedBox(height: 5,),
                      Padding(
                        padding: EdgeInsets.fromLTRB(23, 5, 14, 13),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  Languages.of(context)!.receiptDate,
                                  fontSize: FontSize.fourteen,
                                  color: ColorResource.color101010,
                                  fontWeight: FontWeight.w400,
                                ),
                                CustomText(
                                  widget.bloc.caseList[index].date!,
                                  fontSize: FontSize.fourteen,
                                  color: ColorResource.color101010,
                                  fontWeight: FontWeight.w700,
                                ),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 123,
                              height: 47,
                              child: CustomButton(
                                Languages.of(context)!.selected,
                                fontSize: FontSize.twelve,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }),),
                   ],
                 ),
               ),
             )
           ],
         ),
       );
     }
    );
  }
}