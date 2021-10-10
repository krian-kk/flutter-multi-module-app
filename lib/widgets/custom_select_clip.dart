import 'package:flutter/material.dart';
import 'package:origa/models/select_clip_model.dart';
import 'package:origa/screen/address_screen/bloc/address_bloc.dart';
import 'package:origa/screen/profile_screen.dart/bloc/profile_bloc.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomSelectedClip extends StatefulWidget {
  CustomSelectedClip(
      {Key? key,
      required this.list,
      required this.context,
      required this.selectClipValue,
      required this.selectedColor})
      : super(key: key);

  final List<SelectedClipModel> list;
  final Color selectedColor;
  final BuildContext context;
  String selectClipValue;

  @override
  State<CustomSelectedClip> createState() => _CustomSelectedClipState();
}

class _CustomSelectedClipState extends State<CustomSelectedClip> {
  late AddressBloc bloc;
  @override
  void initState() {
    bloc = AddressBloc()..add(AddressInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      children: _buildUpiSuggestions(),
    );
  }

  List<Widget> _buildUpiSuggestions() {
    List<Widget> widgets = [];
    widget.list.forEach((element) {
      widgets.add(InkWell(
        onTap: () {
          bloc.selectedCustomerNotMetClip = element.clipTitle;
          setState(() {});
          print(bloc.selectedCustomerNotMetClip);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: element.clipTitle == bloc.customerMetGridList
                ? widget.selectedColor
                : ColorResource.colorE7E7E7,
          ),
          child: CustomText(
            element.clipTitle,
            color: ColorResource.color000000,
            fontSize: FontSize.fourteen,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
          ),
        ),
      ));
    });
    return widgets;
  }
}
