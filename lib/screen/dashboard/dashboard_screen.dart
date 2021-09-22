import 'package:flutter/material.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/string_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class DashboardScreen extends StatefulWidget {
   AuthenticationBloc authenticationBloc;
  DashboardScreen(this.authenticationBloc);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(StringResource.origa, 
        color: ColorResource.colorD1D1D1,
        fontSize: 18,fontWeight: FontWeight.w600,),
        centerTitle: true,
      ),
      body: Container(
        child: Center(child: CustomText(
          'Wellcome To Origa', 
          fontSize: 18,
          fontWeight: FontWeight.w600,
          ),
          ),
      ),
    );
  }
}