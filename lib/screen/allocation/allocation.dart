import 'package:flutter/material.dart';
import 'package:origa/authentication/authentication_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/widgets/custom_appbar.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AllocationScreen extends StatefulWidget {
   AuthenticationBloc authenticationBloc;
  AllocationScreen(this.authenticationBloc);

  @override
  _AllocationScreenState createState() => _AllocationScreenState();
}

class _AllocationScreenState extends State<AllocationScreen> {
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomAppbar(
              titleString: 'ALLOCATION',
            ),
          ),
        ],
      ),
    );
  }
}