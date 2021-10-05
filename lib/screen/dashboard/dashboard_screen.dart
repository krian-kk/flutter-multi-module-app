import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/image_resource.dart';
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
          GridView.builder(
            shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 3/2.2,
                maxCrossAxisExtent: 200,

              ),
           itemCount: 5,
           itemBuilder: (BuildContext context,int index) {
          return Wrap(
              children:[ CustomCard(2, Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorResource.color23375A.withOpacity(0.2),
                  ),
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child:
                  Image.asset(ImageResource.vectorArrow),),
                ),
                  CustomText('Count',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  CustomText('200',
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText('Amount',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  CustomText('₹ 3,97,553.67',
                    fontWeight: FontWeight.bold,
                  ),
                ],
            ),
            color: ColorResource.colorFFFFFF,
            height: 130,
            width: 155,
              ),
                CustomCard(02, Row(children: [
                  Container(
                    margin: EdgeInsets.only(left: 5,),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResource.color23375A.withOpacity(0.2),
                    ),
                    child: Container(
                      height: 15,
                      width: 15,
                      child:
                      Image.asset(ImageResource.vectorArrow),),
                  ),
                  SizedBox(width: 3),
                  SizedBox(
                    height: 45,
                      width: 108,
                      child: CustomText('MTD RESOLUTION PROGRESS',
                        fontSize: 12,
                      )),
                ],),height: 63,width: 155,),
                CustomCard(02,Row(children: [
             Container(
             margin: EdgeInsets.only(left: 5,),
             padding: EdgeInsets.all(8),
             decoration: BoxDecoration(
             shape: BoxShape.circle,
             color: ColorResource.color23375A.withOpacity(0.2),
             ),
             child: Container(
             height: 15,
             width: 15,
             child:
             Image.asset(ImageResource.vectorArrow),),
             ),
             SizedBox(width: 3),
             CustomText('MY DEPOSISTS',
             fontSize: 12,
             ),
             ],), height: 54,width: 155,)
         ] );}
          ),
             CustomCard(2, Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
               Container(
                 margin: EdgeInsets.only(left: 5,),
                 padding: EdgeInsets.all(8),
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   color: ColorResource.color23375A.withOpacity(0.2),
                 ),
                 child: Container(
                   height: 15,
                   width: 15,
                   child:
                   Image.asset(ImageResource.vectorArrow),),
               ),
               SizedBox(width: 7),
               CustomText('YARDING & SELF- RELEASE',
                 fontSize: 12,
               ),
             ],),
               height: 65,width: 320,),
             CustomCard(2, Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   margin: EdgeInsets.only(left: 5,),
                   padding: EdgeInsets.all(8),
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: ColorResource.color23375A.withOpacity(0.2),
                   ),
                   child: Container(
                     height: 15,
                     width: 15,
                     child:
                     Image.asset(ImageResource.vectorArrow),),
                 ),
                 SizedBox(width: 7),
                 CustomText('FREQUENTLY ASKED QUESTIONS',
                   fontSize: 12,
                 ),
               ],),
               height: 65,width: 320,),
           ]),
          ));
  }
}