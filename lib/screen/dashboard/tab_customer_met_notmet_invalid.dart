import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/dashboard/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomerMetNotmetInvalidTab extends StatefulWidget {
  final DashboardBloc bloc;
  CustomerMetNotmetInvalidTab(this.bloc, {Key? key}) : super(key: key);

  @override
  _CustomerMetNotmetInvalidTabState createState() => _CustomerMetNotmetInvalidTabState();
}

class _CustomerMetNotmetInvalidTabState extends State<CustomerMetNotmetInvalidTab> {
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
                                 Languages.of(context)!.count.toUpperCase(),
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
                                 Languages.of(context)!.amount.toUpperCase(),
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
                     Expanded(child: CaseLists.buildListView(widget.bloc))
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