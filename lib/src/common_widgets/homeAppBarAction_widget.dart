import 'package:design_system/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class HomeAppBarAction extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool isActive;

  const HomeAppBarAction({
    super.key,
    required this.label,
    required this.iconPath,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (label == ConstantsResourceDesign.allocation) {
        //   context.read<HomeBloc>().add(HomeEvent.allocation);
        // } else if (label == ConstantsResourceDesign.dashboard) {
        //   context.read<HomeBloc>().add(HomeEvent.dashboard);
        // } else if (label == ConstantsResourceDesign.profile) {
        //   context.read<HomeBloc>().add(HomeEvent.profile);
        // } else {
        //   context.read<HomeBloc>().add(HomeEvent.allocation);
        // }
      },
      splashColor: ColorResourceDesign.greyColor,
      child: Ink(
        decoration: isActive
            ? BoxDecoration(
                color: ColorResourceDesign.whiteColor,
                border: Border.all(
                  color: const Color(0xFFECECEC),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              )
            : const BoxDecoration(),
        child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              // borderRadius: BorderRadius.only(
              //   bottomRight: Radius.circular(20),
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(iconPath),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                    color: Color(0xFF151515),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
