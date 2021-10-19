import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:origa/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:origa/screen/dashboard/case_list_widget.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/bottomsheet_appbar.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_read_only_text_field.dart';
import 'package:origa/widgets/custom_text.dart';

class SelfReleaseTab extends StatefulWidget {
  // final DashboardBloc bloc;
  // SelfReleaseTab(this.bloc, {Key? key}) : super(key: key);

  @override
  _SelfReleaseTabState createState() => _SelfReleaseTabState();
}

class _SelfReleaseTabState extends State<SelfReleaseTab> {
  late TextEditingController dateController = TextEditingController();
  late TextEditingController timeController = TextEditingController();
  late TextEditingController remarksController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = '9-21-2021';
    timeController.text = '23:48';
    remarksController.text = 'NKS';
  }
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
     builder: (BuildContext context, StateSetter setState) {
       return Scaffold(
         backgroundColor: ColorResource.colorffffff,
         body: Column(
           // ignore: prefer_const_literals_to_create_immutables
           children: [
             Expanded(
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: CustomReadOnlyTextField(
                          'Date',
                          dateController,
                          isLabel: true,
                          isEnable: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: CustomReadOnlyTextField(
                          'Time*',
                          timeController,
                          isLabel: true,
                          isEnable: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 13),
                        child: CustomReadOnlyTextField(
                          'Remarks*',
                          remarksController,
                          isLabel: true,
                          isEnable: false,
                        ),
                      ),
                      const SizedBox(height: 7,),
                      CustomButton(
                        'UPLOAD DEPOSIT SLIP',
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.sixteen,
                        buttonBackgroundColor: ColorResource.color23375A,
                        cardShape: 50,
                        isLeading: true,
                        trailingWidget: Image.asset(ImageResource.upload),
                      )
                     ],
                   ),
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