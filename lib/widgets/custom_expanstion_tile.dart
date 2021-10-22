// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:origa/utils/color_resource.dart';
import 'package:origa/utils/font.dart';
import 'package:origa/utils/image_resource.dart';
import 'package:origa/widgets/custom_text.dart';

class CustomExpansionTile extends StatefulWidget {
  final String titleText;
  final Color widgetBackgroundColor;
  final Widget? titleWidget;
  final Widget? subtitleWidget;
  final List<Widget> childrenWidget;
  final Color textColor;
  final Color backgroundColor;
  final bool initiallyExpanded;
  final bool maintainState;
  final Color iconColor;
  final Color collapsedBackgroundColor;
  final Color collapsedIconColor;
  final double childrenPadding;
  final Alignment expandedAlignment;
  final Widget? leadingWidget;
  final Widget? trailingWidget;

  CustomExpansionTile({
    Key? key,
    required this.titleText,
    required this.childrenWidget,
    this.widgetBackgroundColor = ColorResource.colorE7E7E7,
    this.subtitleWidget,
    this.titleWidget,
    this.textColor = ColorResource.color000000,
    this.backgroundColor = ColorResource.colorE7E7E7,
    this.collapsedBackgroundColor = ColorResource.colorE7E7E7,
    this.iconColor = ColorResource.color000000,
    this.collapsedIconColor = ColorResource.color000000,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.childrenPadding = 0,
    this.expandedAlignment = Alignment.centerLeft,
    this.leadingWidget,
    this.trailingWidget,
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: ExpansionTile(
        initiallyExpanded: widget.initiallyExpanded,
        maintainState: widget.maintainState,
        title: widget.titleWidget ??
            CustomText(
              widget.titleText,
              color: ColorResource.color000000,
              fontSize: FontSize.fourteen,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w700,
            ),
        subtitle: widget.subtitleWidget,
        textColor: widget.textColor,
        backgroundColor: widget.backgroundColor,
        iconColor: widget.iconColor,
        leading: widget.leadingWidget,
        trailing: widget.trailingWidget ??
            Image.asset(ImageResource.expandedDownShape),
        collapsedIconColor: widget.collapsedIconColor,
        collapsedBackgroundColor: widget.collapsedBackgroundColor,
        childrenPadding: EdgeInsets.all(widget.childrenPadding),
        expandedAlignment: widget.expandedAlignment,
        children: widget.childrenWidget,
      ),
    );
  }
}
