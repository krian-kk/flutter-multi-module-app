import 'package:design_system/app_sizes.dart';
import 'package:design_system/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../gen/assets.gen.dart';

class DashboardView extends StatelessWidget {
  DashboardView({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> gridMap = [
    {
      "label": "PRIORITY FOLLOW UP",
      "count": "200",
      "amount": "₹ 3,97,553.67",
    },
    {
      "label": "BROKEN PTP",
      "count": "200",
      "amount": "₹ 3,97,553.67",
    },
    {
      "label": "UNTOUCHED CASES",
      "count": "200",
      "amount": "₹ 3,97,553.67",
    },
    {
      "label": "MY VISITS",
      "count": "200",
      "amount": "₹ 3,97,553.67",
    },
    {
      "label": "MY RECEIPTS",
      "count": "200",
      "amount": "₹ 3,97,553.67",
    },
    {
      "label": "MTD RESOLUTION PROGRESS",
      "count": "null",
      "amount": "null",
    },
    {
      "label": "MY DEPOSITS",
      "count": "null",
      "amount": "null",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(
            left: Sizes.p20, right: Sizes.p20, top: Sizes.p10),
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: StaggeredGridView.countBuilder(
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: gridMap.length,
                itemBuilder: (context, index) {
                  return DashboardTile(gridMap: gridMap, index: index);
                },
              ),
            ),
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: DashboardLongBtn(label: 'YARDING & SELF- RELEASE'),
                ),
                DashboardLongBtn(label: 'FREQUENTLY ASKED QUESTIONS'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  const DashboardTile({
    super.key,
    required this.gridMap,
    required this.index,
  });

  final List<Map<String, dynamic>> gridMap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: const Color(0xFFDDDDDD),
      child: Ink(
        width: 155,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0xFFDADADA),
            )
          ],
          border: Border.all(
            width: 0.5,
            color: const Color(0xFFDADADA),
          ),
        ),
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("${gridMap.elementAt(index)['label']}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF101010),
                        )),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFcaced5),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: SvgPicture.asset(Assets.images.dashboardArrowUp),
                    // child: const Icon(
                    //   AllocationIcons.dashboard_arrowup,
                    //   color: Color(0xFF23375A),
                    // ),
                  ),
                ],
              ),
              gridMap.elementAt(index)['count'] != "null"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Count',
                            style: TextStyle(
                              color: Color(0xFF101010),
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            )),
                        Text(
                          "${gridMap.elementAt(index)['count']}",
                          style: const TextStyle(
                            color: Color(0xFF101010),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              gridMap.elementAt(index)['amount'] != "null"
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Amount',
                            style: TextStyle(
                              color: Color(0xFF101010),
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            )),
                        Text(
                          "${gridMap.elementAt(index)['amount']}",
                          style: const TextStyle(
                            color: Color(0xFF101010),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardLongBtn extends StatelessWidget {
  final String label;

  const DashboardLongBtn({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      splashColor: const Color(0xFFDDDDDD),
      child: Ink(
        width: 320,
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Color(0xFFDADADA),
            )
          ],
          border: Border.all(
            width: 0.5,
            color: const Color(0xFFDADADA),
          ),
        ),
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Color(0xFF101010),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFcaced5),
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: SvgPicture.asset(Assets.images.dashboardArrowUp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
