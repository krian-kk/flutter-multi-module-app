import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';

class PriorityFollowUpBottomSheet extends StatefulWidget {
  PriorityFollowUpBottomSheet({Key? key}) : super(key: key);

  @override
  _PriorityFollowUpBottomSheetState createState() => _PriorityFollowUpBottomSheetState();
}

class _PriorityFollowUpBottomSheetState extends State<PriorityFollowUpBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
               decoration:const BoxDecoration(
                 color: ColorResource.colorF7F8FA,
                borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
               ),
               height: MediaQuery.of(context).size.height * 0.85,
               child:  StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return WillPopScope(
                    onWillPop: () async => false,
                    child: SafeArea(
                      bottom: false,
                      child: Scaffold(
                          body: Container(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Text('data')),
                          ),
                                ),
                      ),
                  );
                }
               ),
    );
  }
}