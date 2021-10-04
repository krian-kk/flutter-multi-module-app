import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_card_widget.dart';
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
      body: SafeArea(
       child: Column(
           children: [
          Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: GridView.builder(
              shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 3/2.2,
                  maxCrossAxisExtent: 200,

                ),
             itemCount: 5,
             itemBuilder: (BuildContext context,int index) {
            return Wrap(
                children:[ CustomCard(2, Container(
              ),
              color: ColorResource.colorFFFFFF,
              height: 130,
              width: 155,
                ),
                  CustomCard(02, Text(''),height: 63,width: 155,),
                  CustomCard(02, Text(''),height: 54,width: 155,)
         ] );}
            ),
          ),
             CustomCard(2, Text(''),
               height: 65,width: 320,),
             CustomCard(2, Text(''),
               height: 65,width: 320,),
           ]),
          ));
  }
}