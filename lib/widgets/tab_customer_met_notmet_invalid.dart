// import 'package:flutter/material.dart';
// import 'package:origa/models/dashboard_model.dart';
// import 'package:origa/widgets/case_list_widget.dart';

// class CustomerMetNotmetInvalidTab extends StatefulWidget {
//   // final DashboardBloc bloc;
//   final List<CaseListModel> caseList;
//   const CustomerMetNotmetInvalidTab(this.caseList, {Key? key})
//       : super(key: key);

//   @override
//   _CustomerMetNotmetInvalidTabState createState() =>
//       _CustomerMetNotmetInvalidTabState();
// }

// class _CustomerMetNotmetInvalidTabState
//     extends State<CustomerMetNotmetInvalidTab> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//       return Scaffold(
//         body: Column(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                 child: CaseLists.buildListView(widget.caseList),
//               ),
//             )
//           ],
//         ),
//       );
//     });
//   }
// }
