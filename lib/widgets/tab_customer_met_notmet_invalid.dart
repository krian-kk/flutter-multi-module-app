import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:origa/languages/app_languages.dart';
import 'package:origa/models/dashboard_model.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/widgets/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomerMetNotmetInvalidTab extends StatefulWidget {
  // final DashboardBloc bloc;
  final List<CaseListModel> caseList;
  CustomerMetNotmetInvalidTab(this.caseList, {Key? key}) : super(key: key);

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
                 child: CaseLists.buildListView(widget.caseList),
               ),
             )
           ],
         ),
       );
     }
    );
  }
}