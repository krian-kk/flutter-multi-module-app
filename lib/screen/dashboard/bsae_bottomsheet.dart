import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return WillPopScope(
          onWillPop: () async => false,
           child: SafeArea(
             bottom: false,
             child: SizedBox(
               height: MediaQuery.of(context).size.height * 0.82,
               child: Scaffold(
                body: Container(
                  child: Text('data'),
                ),
                       ),
             ),
           ),
        );
      }
    );
  }
}