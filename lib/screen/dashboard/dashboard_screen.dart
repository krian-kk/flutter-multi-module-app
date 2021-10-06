import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/screen/dashboard/priority_follow_up_bottomsheet.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_button.dart';
import 'package:origa/widgets/custom_text.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardScreen extends StatefulWidget {

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
   String version = "";

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

   Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.colorF7F8FA,
      // appBar: AppBar(
      //   title: CustomText(StringResource.origa, 
      //   color: ColorResource.colorD1D1D1,
      //   fontSize: 18,fontWeight: FontWeight.w600,),
      //   centerTitle: true,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(child: CustomText(
              'Dashboard', 
              fontSize: 18,
              fontWeight: FontWeight.w600,
              ),
              ),
          ),
          SizedBox(height: 30,),
          CustomButton(
            'Priority Follow Up',
            onTap: (){
              priorityFollowUpSheet(context);
            },
          ),
          SizedBox(height: 30,),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomText(
              'v$version', 
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade400,
              ),
          ),
        ],
      ),
    );
  }


  void priorityFollowUpSheet(BuildContext buildContext) {
    showCupertinoModalPopup(
        // isScrollControlled: true,
        // elevation: 13,
        // isDismissible: false,
        context: buildContext,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        // ),
        // backgroundColor: ColorResource.colorFFFFFF,
        builder: (BuildContext context) {
          return PriorityFollowUpBottomSheet();
        });
  }
}